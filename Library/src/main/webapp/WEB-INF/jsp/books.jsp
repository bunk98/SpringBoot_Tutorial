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