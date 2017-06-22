<%@tag body-content ="empty"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
    <c:when test="${mensagem != null}">
        ${mensagem}
    </c:when>
    <c:otherwise>
        Entre com seu usuario e senha
    </c:otherwise>
</c:choose>