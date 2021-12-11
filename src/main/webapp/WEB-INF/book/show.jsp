<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
			<div class="col">
				<h1>Welcome, <c:out value="${ user.getUserName() }"/></h1>
				<p>Books from everyone's shelves:</p>
			</div>
			<div class="col">
				<div>
					<a href="/books/logout">Logout</a>
				</div>
				<div>
					<a href="/books/new">+ Add book to my shelf!</a>
				</div>
			</div>
		</div>
		<!-- SHOW DATA WITH EDIT ROUTE -->
		<table class="table">
			<thead>
				<tr>
					<th class="col-1">ID</th>
					<th class="col-3">Title</th>
					<th class="col-3">Author Name</th>
					<th class="col-3">Posted By</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${ books }">
					<tr>
						<td><c:out value="${ book.id }" /></td>
						<td><a href="/books/${ book.id }"><c:out value="${ book.title }" /></a></td>
						<td><c:out value="${ book.author }" /></td>
						<c:if test=""></c:if>
						<td><c:out value="${ book.user_id.getUserName() }" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>