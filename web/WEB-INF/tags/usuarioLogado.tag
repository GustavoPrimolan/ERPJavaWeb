<%@tag body-content ="empty"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
    <c:when test="${nomeCompleto != null}">
        Usu�rio: ${nomeCompleto}
    </c:when>
    <c:otherwise>
        Usu�rio: N�o logado
    </c:otherwise>
</c:choose>