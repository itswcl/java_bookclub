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
		<div class="row d-flex">
			<h1>
				<c:out value="${ book.title }" />
			</h1>
			<a href="/books">back to the shelves</a>
		</div>
		
		<!-- EDIT CLASS FORM -->
		<form:form action="/books/edit/${book.id}" method="post"
			modelAttribute="book">
			<input type="hidden" name="_method" value="put">
			
			<form:input type="hidden" path="user_id"
				value="${ book.user_id.getId() }" />
			<form:input type="hidden" path="borrow_id"
				value="${ book.getBorrow_id().getId() }" />

			<form:errors path="*" />
			<p>
				<form:label path="title">Title</form:label>
				<form:input path="title" />
			</p>
			<p>
				<form:label path="author">Autho</form:label>
				<form:input path="author" />
			</p>
			<p>
				<form:label path="thought">My thoughts</form:label>
				<form:input path="thought" />
			</p>

			<input type="submit" value="Edit" />
		</form:form>

	</div>

</body>
</html>