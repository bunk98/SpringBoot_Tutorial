# alex-project
stage 03 demo by alex newquist

This project will contain a step by step implementation of a simple 
Java Springboot application making use of a JSP front end and a CRUD
implementation of a embedded hibernate database. 

Each step will be built into the commit history of this project (see
history for code at each step) 

For each step find below an explanation of each process I used to complete
 it and helpful resources for gaining a better understanding of the technologies
 and code. 
 
 Before running through these steps here are a couple nice resources for gaining 
 a better understanding of what exactly the Java Spring/Springboot framework is. 
 
 I highly recommend Sping.io and Baeldung for everything learning and understanding SB

https://spring.io/projects/spring-boot
https://www.baeldung.com/spring-boot
https://docs.spring.io/spring-boot/docs/current/reference/html/using-spring-boot.html#using-boot-auto-configuration

I recommend Intellij for SB dev as it has become the norm in industry however eclipse, etc. 
are also fine choices.
-----------------------------------------------------------------------------------------------------
Step 1: Lets get our SB application to build 

For every SB application I make I start here: https://start.spring.io/

That link will take you to a web tool that will generate an "empty" SB application 
file structure. You will notice several different options to choose from regarding 
specs for your app. 

Here are the docs for it: https://docs.spring.io/initializr/docs/current/reference/html/

I highly recommend skimming them if you have an interest in this tool but do not get too hung
up on generating the right initial build, just start by using mine. 

Note- If you do wish to use the Spring Initializr for your project make sure to
check that everything I have in my build is also present in yours:

Here is a bit about java maven project builds: https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

Your pom.xml should contain everything that I have in mine depenedency wise, java version etc. 
If you use the Spring Initializr note that you will not find the dependencies relating to JSP(Jasper) and JSTL just copy and add mine.
There is no reason for this other than JSPs are just used less commonly than other UI tools ie. Java Script frameworks

Also go into the test folder then java folder and delete what gets put there. These are auto generated test case stubs that will
cause your build issues. 



Make the following code block your main. I will add comments under each code block about anything I pick out as important to note but I may not catch everything- look to Google/Baeldung
for further explanation.

We see our first annotations here, this is how Spring framework uses annotations:https://www.baeldung.com/spring-boot-annotations

I highly suggest googling all spring annotations you see, they have crucial functionalitly in SB.

Big learning curve I had with annotations- Dependency Injection. This is one of the most powerful patterns enabled by SB, pay close attention
 to this and how the autowired annotation works in relation to it:
https://www.freecodecamp.org/news/a-quick-intro-to-dependency-injection-what-it-is-and-when-to-use-it-7578c84fa88f/
https://docs.spring.io/spring-boot/docs/current/reference/html/using-spring-boot.html#using-boot-spring-beans-and-dependency-injection

_______________________
package com.devcases.springboot.crud.library;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableAutoConfiguration 
@ComponentScan(basePackages={"com.devcases.springboot.crud.library"}) 
@EnableJpaRepositories(basePackages="com.devcases.springboot.crud.library.repository")
public class Application extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}

____________________________________________________________________________

@SpringBootApplication
@EnableAutoConfiguration These guys enable autoconfiguration and are related to autowired- we will see in next stage.

@ComponentScan(basePackages={"com.devcases.springboot.crud.library"}) 
 This guy enables all of our annotated classes to be read by our app.
 
 @EnableJpaRepositories(basePackages="com.devcases.springboot.crud.library.repository")
 This guy will enable our simple embedded database


Build and run your SB app to make sure your embedded Tomcat starts up and that your dependencies are being read in. Check against my build
if any errors and often google can clear up many of your initial start up issues.

-------------------------------------------------------------------------------

Step 02 Lets have our application pull up a simple set of JSPs. 

Note: in terms of our MVC model in the context of a web app we can think of our view as the JSPs
and our controller as the controller we will discuss below

In your main create a folder called webapp and put your WEB-INF here.
Then place a jsp folder in WEB-INF that contains three .jps files: 

books.jsp
------------------------------------------------------------------------
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <%@ page isELIgnored="false" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Library</title>
</head>
<body>
    <div>
        <div>
            <h2>Library</h2>
            <hr/>
            <a href="/new-book">
                <button type="submit">Add new book</button>
            </a>
            <br/><br/>
            <div>
                <div>
                    <div>Book list</div>
                </div>
                <div>
                    <table>
                        <tr>
                            <th>Id</th>
                            <th>Author</th>
                            <th>Name</th>
                        </tr>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td>${book.id}</td>
                                <td>${book.author}</td>
                                <td>${book.name}</td>
                                <td>
                                    <a href="/${book.id}">Edit</a>
                                    <form action="/${book.id}/delete" method="post">
                                        <input type="submit" value="Delete" />
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
------------------------------------------------------------------------
edit-book.jsp
------------------------------------------------------------------------
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <%@ page isELIgnored="false" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Library</title>
</head>
<body>
    <div>
        <h2>New User</h2>
        <div>
            <div>
                <form:form action="${book.id}/update" modelAttribute="book" method="post">
                    <div>
                        <div>
                            Id: ${book.id}
                        </div>
                        <div>
                            <form:label path="author">Author</form:label>
                            <form:input type="text" id="author" path="author"/>
                            <form:errors path="author" />
                        </div>
                        <div>
                            <form:label path="name">Name</form:label>
                            <form:input type="text" id="name" path="name"/>
                            <form:errors path="name" />
                        </div>
                    </div>
                    <div>
                        <div>
                            <input type="submit" value="Update User">
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    </body>
</html>
------------------------------------------------------------------------
new-book.jsp
------------------------------------------------------------------------
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <%@ page isELIgnored="false" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Library</title>
</head>
<body>
    <div>
        <h2>New User</h2>
        <div>
            <div>
                <form:form action="/add" modelAttribute="book" method="post">
                    <div>
                        <div>
                            <form:label path="author">Author</form:label>
                            <form:input type="text" id="author" path="author"/>
                            <form:errors path="author" />
                        </div>
                        <div>
                            <form:label path="name">Name</form:label>
                            <form:input type="text" id="name" path="name"/>
                            <form:errors path="name" />
                        </div>
                    </div>
                    <div>
                        <div>
                            <input type="submit" value="Add User">
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    </body>
</html>
------------------------------------------------------------------------

Overall these are fairly standard html pages but a couple things to note: 

Notice the form tags. These are read when we render our forms as we have added the JSTL and JSP dependencies in our pom.xml
More on JSTL and JSP:
https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/view.html

Notice how form tags are used for each page. In new book and edit book they contain inputs for books to be entered into the DB we will spin up
and in books we notice that this time we still have a form tag to observe our submit action but also:
c:forEach var="book" items="${books} which can be looked at as a variation of list comprehension that will return books from our app logic/DB
and put them in an html table in this case. 


Before adding our contoller lets quickly add a POJO called book to serve as our books to store. 
Place a folder called entity in our library folder in which we create a class called book containing the following
--------------------------------------------------------------------------------------------------------------------

package com.devcases.springboot.crud.library.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @NotBlank(message = "Author is mandatory")
    private String author;

    @NotBlank(message = "Name is mandatory")
    private String name;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
--------------------------------------------------------------------------------
While this is a simple java object, take note of the annotations present. These are
to help us store book objects in our DB in the future. 

Now lets add our controller in
--------------------------------------------------------------------------------


package com.devcases.springboot.crud.library.controller;

import com.devcases.springboot.crud.library.entity.Book;
//import com.devcases.springboot.crud.library.model.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class LibraryController {

//    private BookService service;

//    @Autowired
//    public LibraryController(BookService service) {
//        this.service = service;
//    }

    @GetMapping
    public String showAllBooks(Model model) {
   //     model.addAttribute("books", service.findAll());
        return "books";
    }

    @GetMapping("/new-book")
    public String showBookCreationForm(Model model) {
        model.addAttribute("book", new Book());
        return "new-book";
    }

    @PostMapping(value = "/add", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String addNewBook(@Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "new-book";
        }
   //     service.save(book);
   //     model.addAttribute("books", service.findAll());
        return "books";
    }

    @GetMapping("/{id}")
    public String showBookdById(@PathVariable Long id, Model model) {
//        Book book = service.findById(id)
//                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
//        model.addAttribute("book", book);
        return "edit-book";
    }

    @PostMapping("/{id}/update")
    public String updateBook(@PathVariable Long id, @Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "edit-book";
        }
//        service.findById(id)
//                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
//        service.save(book);
//        model.addAttribute("books", service.findAll());
        return "books";
    }

    @PostMapping("/{id}/delete")
    public String deleteBook(@PathVariable Long id, Model model) {
//        service.findById(id)
//                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
//        service.deleteById(id);
//        model.addAttribute("books", service.findAll());
        return "books";
    }
}

--------------------------------------------------------------------------------
Notice at this stage I have commented out all application logic calls in our controller.  I did not want to completely 
delete these as I felt leaving them would give a more wholistic view but please copy the code and delete it to 
focus more on the controller logic if the commented code is distracting. 

Things to look at: 

How are HTTP post, get, etc. calls mapped to JSPs based on our controllers? 
How is data from the forms being read into these controllers?

Here is a very short tutorial/resource that will be helpful for beginning your exploration
of how these controllers read and interact with JSP forms.
https://hellokoding.com/spring-boot-hello-world-example-with-jsp/

Here is an excellent tool for testing controllers/APIs widely used in industry:
https://www.postman.com/downloads/
Use it to play around with sending different requests to your localhost and look at
the payloads you send and recieve. (note you will get errors doing this until
you have completely finished step 2 but take note of the errors and look at why the following
steps fixed them) 

You may also wonder how when we click buttons do we not only have an action happen but also move to 
another page? For this take a look at what we are returning in each of these request mappers, you will find 
names of other JSPs- thus how we navigate from page to page after our initial landing at localhost:8080

Looking at the commented code at this point you can also start to see how this data is going to be 
passed to the DB. 

This is also a good time to quickly add to our resources folder. This folder can essentially just be 
looked at as a place to store helpful bits of this and that for our application.

for our app all we simply need is to add to our application.properties by writing: 

spring.mvc.view.prefix: /WEB-INF/jsp/
spring.mvc.view.suffix: .jsp
server.port={YOUR_PORT}

Note Spring Initializr will have created a blank app.properties file for you

Make sure to replace your port 
There are many different uses for the application.properties file as
well as multiple ways to incorporate resources into your application.

More info on application.properties and alternatives to explore: 
https://www.tutorialspoint.com/spring_boot/spring_boot_application_properties.htm#:~:text=Properties%20files%20are%20used%20to,src%2Fmain%2Fresources%20directory.

Lets test our work so far- run your application and go to localhost:8080

At this point you will see your JSP home. Click add. Enter names. Test your @NotBlank contraints. Everything should be working with
one issue: books you enter are not being saved. This is because we have not yet implemented our database, lets do that next. 

----------------------------------------------------------------------------------------------------------------------------------------------------

Step03

Here we will implment our DB using CRUD. This is a very simple embedded DB, it can almost be thought of a big array list:
Here is an essentially identical implemenation to our own with a nice explaination:
https://howtodoinjava.com/spring-boot2/spring-boot-crud-hibernate/

In terms of MVC this DB and the service class I will explain below equate to our model. 

Lets First comment in our service calls that are present in our Controller

--------------------------------------------------------------------------------------------------------------------------------------

package com.devcases.springboot.crud.library.controller;

import com.devcases.springboot.crud.library.entity.Book;
import com.devcases.springboot.crud.library.model.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class LibraryController {

    private BookService service;

    @Autowired
    public LibraryController(BookService service) {
        this.service = service;
    }

    @GetMapping
    public String showAllBooks(Model model) {
        model.addAttribute("books", service.findAll());
        return "books";
    }

    @GetMapping("/new-book")
    public String showBookCreationForm(Model model) {
        model.addAttribute("book", new Book());
        return "new-book";
    }

    @PostMapping(value = "/add", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String addNewBook(@Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "new-book";
        }
        service.save(book);
        model.addAttribute("books", service.findAll());
        return "books";
    }

    @GetMapping("/{id}")
    public String showBookdById(@PathVariable Long id, Model model) {
        Book book = service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        model.addAttribute("book", book);
        return "edit-book";
    }

    @PostMapping("/{id}/update")
    public String updateBook(@PathVariable Long id, @Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "edit-book";
        }
        service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        service.save(book);
        model.addAttribute("books", service.findAll());
        return "books";
    }

    @PostMapping("/{id}/delete")
    public String deleteBook(@PathVariable Long id, Model model) {
        service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        service.deleteById(id);
        model.addAttribute("books", service.findAll());
        return "books";
    }
}

---------------------------------------------------------------------------------------------------------------------------


Now lets add the service that our API calls.

What is the service class? The service class simply serves as a "middleman" between our controller/API and DB model.
This is mainly just because it is best practice to not link a DB directly to a controller. 


Here is our service, add it to a class called BookService in a folder called model within our Library folder: 

------------------------------------------------------------------------------------------------------------------------------

package com.devcases.springboot.crud.library.model;

import com.devcases.springboot.crud.library.entity.Book;
import com.devcases.springboot.crud.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class BookService {

    private BookRepository repository;

    @Autowired
    public BookService(BookRepository repository) {
        this.repository = repository;
    }

    public List<Book> findAll() {
        return StreamSupport.stream(repository.findAll().spliterator(), false)
                .collect(Collectors.toList());
    }

    public Optional<Book> findById(Long id) {
        return repository.findById(id);
    }

    public Book save(Book stock) {
        return repository.save(stock);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
--------------------------------------------------------------------------------------

To understand the Service class better lets also add in the DB/Repository interface and call 
it BookRepository. Place it in a folder called repository in the the library folder. 

--------------------------------------------------------------------------------------
package com.devcases.springboot.crud.library.repository;

import com.devcases.springboot.crud.library.entity.Book;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {

}
---------------------------------------------------------------------------------------

Some things to look at in our Service and Repository: 

Take note of the @Serive and @Repository annotations and what they allow.
https://www.baeldung.com/spring-component-repository-service

Also look carefully at the autowiring in Controller and Service, this is one of the most 
important aspects of spring as it is how our Model, View and Controller are linked together.
This is the best explaination of autowiring I have found, notice in our application we autowire
components using constructors.
https://www.tutorialspoint.com/spring/spring_autowired_annotation.htm

After previosuly reviewing how a CRUD DB works https://howtodoinjava.com/spring-boot2/spring-boot-crud-hibernate/
you will notice that within the methods in the Service class we are making the standard edit calls to the DB. 

Take note of how these Service methods are then called in the controller. That is how you will 
gain an understanding of how our controller/API communicates with our DB.

An area that this application could be improved is
swapping our embedded DB out for an actual on disk relational or otherwise DB. 
To make this happen the beauty of MVC is all you would have to do is change out your 
repository class and make tweaks to your service class so that it will still make calls to your 
repository correctly ie. use SQL statements in a relational DB implemenation.

At this point you have completed your application! In the final stage after this I will briefly run through the steps to 
deploy the application to Silo. Make sure to test your app locally to make sure your books are being saved and that you can edit
and delete existing books. 

------------------------------------------------------------------------------------------------------------------------------









