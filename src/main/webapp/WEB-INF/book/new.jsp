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
<title>Starting page</title>
</head>
<body>

	<div class="container">
		<div class="d-flex justify-content-around p-5">
			<h1>Add a Book to Your Shelf!</h1>
			<a href="/books">back to the shelves</a>
		</div>
		<!-- ADD NEW CLASS FORM -->
		<form:form class="form-group col-5" action="/books/new" method="post"
			modelAttribute="book">
			<form:errors path="*" />
			<form:input type="hidden" path="user_id" value="${ user_id }"/>
			<p>
				<form:label path="title">Title</form:label>
				<form:input class="form-control" path="title" />
			</p>
			<p>
				<form:label path="author">Author</form:label>
				<form:input class="form-control" path="author" />
			</p>
			<p>
				<form:label path="thought">Thought</form:label>
				<form:input class="form-control" path="thought" />
			</p>
			<input class="btn btn-primary" type="submit" value="Submit" />
		</form:form>

	</div>

</body>
</html>