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
			<div class="col">
				<h3>
					Hello,
					<c:out value="${ user.getUserName() }" />
					Welcome to..
				</h3>
				<h1>The Book Broker!</h1>
				<h3>Available Books to Borrow</h3>
			</div>
			<div class="col">
				<a href="books">back to the shelves</a>
			</div>
		</div>
		<!-- SHOW DATA WITH EDIT ROUTE -->
		<table class="table text-center">
			<thead>
				<tr>
					<th class="col-1">ID</th>
					<th class="col-3">Title</th>
					<th class="col-3">Author Name</th>
					<th class="col-3">Owner</th>
					<th class="col-3">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${ books }">

					<tr>
					<c:if test="${ book.borrow_id == null }">
						<td><c:out value="${ book.id }" /></td>
						<td><a href="/books/${ book.id }"><c:out
									value="${ book.title }" /></a></td>
						<td><c:out value="${ book.author }" /></td>
						<td><c:out value="${ book.user_id.getUserName() }" /></td>

						<c:if test="${  user_id == book.user_id.getId() }">
							<td class="d-flex"><a class="btn btn-primary me-md-2"
								href="/books/edit/${ book.id }">Edit</a> <!-- careful with adding route remeber to have / in front -->
								<form:form action="/books/delete/${book.id}" method="post">
									<input type="hidden" name="_method" value="delete">
									<input class="btn btn-primary" type="submit" value="Delete" />
								</form:form></td>
						</c:if>

						<c:if test="${  user_id != book.user_id.getId() }">
							<td><form:form action="bookmarket/borrow/${ book.id }"
									method="post" modelAttribute="book">
									<input type="hidden" name="_method" value="put" />
									<form:input type="hidden" path="borrow_id"
										vale="${ user.getId() }" />
									<input class="btn btn-primary" type="submit" value="Borrow" />
								</form:form></td>
						</c:if>
						
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<h3>Books I'm Borrowing..</h3>
		<table class="table text-center">
			<thead>
				<tr>
					<th class="col-1">ID</th>
					<th class="col-3">Title</th>
					<th class="col-3">Author Name</th>
					<th class="col-3">Owner</th>
					<th class="col-3">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="borrowBook" items="${ userBorrows }">
					<tr>
						<td><c:out value="${ borrowBook.id }" /></td>
						<td><a href="/books/${ borrowBook.id }"><c:out
									value="${ borrowBook.title }" /></a></td>
						<td><c:out value="${ borrowBook.author }" /></td>
						<td><c:out value="${ borrowBook.user_id.getUserName() }" /></td>
						<td><a class="btn btn-primary" href="#">return</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

</body>
</html>