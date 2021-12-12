<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- Bootstrap JS or jQuery-->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<title>Book Club</title>
</head>
<body>

	<div class="container">
		<div class="row d-flex">
			<h1>
				<c:out value="${ book.title }" />
			</h1>
			<a href="/books">back to the shelves</a>
		</div>
		<!-- to test if the session user id matched the book's user is
		if it match we use "You" to represent the user name -->
		<c:if test="${ user_id == book.user_id.getId()}">
			<h3>
				<span style="color: red;">You</span> read <span
					style="color: purple;"><c:out value="${ book.title }" /></span> by
				<span style="color: green;"><c:out value="${ book.author }" /></span>.
			</h3>
			<h3>Here are Your thoughts:</h3>
			<p>
				<c:out value="${ book.thought }" />
			</p>
			<a class="btn" href="/books/edit/${ book.id }">Edit</a>
			
			<!-- careful with adding route remeber to have / in front -->
			<form:form action="/books/delete/${book.id}" method="post">
				<input type="hidden" name="_method" value="delete">
				<input class="btn" type="submit" value="Delete" />
			</form:form>

		</c:if>
		<!-- ------------------------------------------------------------------------------------ -->
		<!-- to test if the session user id matched the book's user is
		if it does NOT match we use name to represent the user name -->
		<c:if test="${ user_id != book.user_id.getId()}">
			<h3>
				<span style="color: red;"><c:out
						value="${ book.user_id.getUserName() }" /></span> read <span
					style="color: purple;"><c:out value="${ book.title }" /></span> by
				<span style="color: green;"><c:out value="${ book.author }" /></span>.
			</h3>
			<h3>
				Here are
				<c:out value="${ book.user_id.getUserName() }" />
				's thoughts:
			</h3>
			<p>
				<c:out value="${ book.thought }" />
			</p>
		</c:if>

	</div>

</body>
</html>