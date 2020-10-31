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
 a better understanding of what exactly the Java Spring/Springboot. 
 
 I highly recommend Sping.io and Baeldung for everything learning and understanding SB

https://spring.io/projects/spring-boot
https://www.baeldung.com/spring-boot
https://docs.spring.io/spring-boot/docs/current/reference/html/using-spring-boot.html#using-boot-auto-configuration

I recommend Intellij for SB dev as it has become the norm in industry however eclipse, etc. 
are also fine choices.

Step 1: Lets get our SB application to build 

For every SB application I make I start here: https://start.spring.io/

That link will take you to a web tool that will generate an "empty" SB application 
file structure. You will notice several different options to choose from regarding 
specs for your app. 

Here are the docs for it: https://docs.spring.io/initializr/docs/current/reference/html/

I highly recommend skimming them if you have an interest in this tool but do not get too hung
up on generating the right initial build, just start by using mine. 

Note- If you do wish do wish to use the Spring Initializr for your make sure to
check that everything I have in my build is also present in yours:

Here is a bit about java maven prject builds: https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

Your pom.xml should contain everything that I have in mine depenedency wise, java version etc. 
If you use the Spring Initializr note that you will not find the dependencies relating to JSP(Jasper) and JSTL just copy and add mine.
There is no reason for this other than they are just used less commonly than other UI tools ie. Java Script frameworks

Also go into the test folder then java folder and delete what gets put there. These are auto generated test case stubs that will
cause your build issues. 



Make the following code block your main. I will add comments to anything I pick out as important to note but I may not catch everything- look to Google/Baeldung
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
@EnableAutoConfiguration //These guys enable autoconfiguration and are related to autowired- we will see in next stage.
@ComponentScan(basePackages={"com.devcases.springboot.crud.library"}) //This guy enables all of our annotated classes to be read by our app.
@EnableJpaRepositories(basePackages="com.devcases.springboot.crud.library.repository") //this guy will enable our simple embedded database
public class Application extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}

____________________________________________________________________________


Build and run your SB app to make sure your embedded Tomcat starts up and that your dependencies are being read in. Check against my build
if any errors and often google can clear up many of your initial start up issues.













