<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報　詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${report.report_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td><fmt:formatDate value="${report.created_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td><fmt:formatDate value="${report.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                    </tbody>
                </table>

                <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                    <p><a href="<c:url value="/reports/edit?id=${report.id}" />">この日報を編集する</a></p>
                </c:if>

                <c:if test="${sessionScope.login_employee.id == report.employee.id ||
                                sessionScope.login_employee.admin_flag == 1}">
                    <label for="comments">コメント一覧</label>
                        <table>
                            <tr>
                                <th>氏名</th>
                                <th>日付</th>
                                <th>コメント</th>
                            </tr>
                            <c:forEach var="comment" items="${comments}" varStatus="status">
                                <tr class="row${status.count % 2}">
                                    <td><c:out value="${comment.name}" /></td>
                                    <td><fmt:formatDate value="${comment.create_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td><a href="<c:url value='/comments/show?id=${comment.id}' />"><c:out value="${index.get(status.count - 1)}" /></a></td>
                                </tr>
                            </c:forEach>
                        </table>

                        <div id="pagination">
                            (全 ${comments_count} 件)<br />
                            <c:forEach var="i" begin="1" end="${(comments_count - 1) / 15 + 1}" step="1">
                                <c:choose>
                                    <c:when test="${page == i}">
                                        <c:out value="${i}" />&nbsp;
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='/reports/show?page=${i}&&id=${report.id}' />"><c:out value="${i}" /></a>&nbsp;
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                </c:if>

                <c:if test="${sessionScope.login_employee.admin_flag == 1}">
                    <form name="comment" method="POST" action="<c:url value='/comments/create' />">
                        <label for="content">コメント</label><br />
                        <textarea name="content" rows="10" cols="50"></textarea><br />
                        <input type="hidden" name="report_id" value="${report.id}" />
                        <input type="hidden" name="name" value="${login_employee.name}" />
                        <input type="hidden" name="_token" value="${_token}" />
                        <button type="submit">投稿</button>
                    </form>
                </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value="/reports/index" />">一覧に戻る</a></p>
    </c:param>
</c:import>