<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">
<jsp:include page="fragments/headTag.jsp"/>


<body>
<H3>PETCLINIC VERSION : ${project.version}</H3>

<div class="container">
    <jsp:include page="fragments/bodyHeader.jsp"/>
    <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
    <img src="${petsImage}"/>

    <jsp:include page="fragments/footer.jsp"/>

</div>
</body>
</html>
