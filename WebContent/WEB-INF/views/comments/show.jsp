<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${comment != null}">
                <h2>コメント　詳細</h2>
                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${comment.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${comment.create_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <th>コメント</th>
                            <td><pre><c:out value="${comment.content}" /></pre></td>
                        </tr>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value='/reports/show?id=${comment.report_id}' />">日報詳細に戻る</a></p>
        <p><a href="<c:url value='/reports/index' />">日報一覧に戻る</a></p>
    </c:param>
</c:import>