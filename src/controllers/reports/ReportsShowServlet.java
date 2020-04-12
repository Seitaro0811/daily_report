package controllers.reports;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Comment;
import models.Employee;
import models.Report;
import utils.DBUtil;

/**
 * Servlet implementation class ReportsShowServlet
 */
@WebServlet("/reports/show")
public class ReportsShowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportsShowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Report r = em.find(Report.class, Integer.parseInt(request.getParameter("id")));

        request.setAttribute("report", r);
        request.setAttribute("_token", request.getSession().getId());
        request.setAttribute("login_employee", (Employee)request.getSession().getAttribute("login_employee"));

        Employee login_employee = (Employee)request.getSession().getAttribute("login_employee");
        Employee report_employee = (Employee)r.getEmployee();
        if(login_employee.getId() == report_employee.getId() || login_employee.getAdmin_flag() == 1) {

            int page;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch(Exception e) {
                page = 1;
            }

            List<Comment> c = em.createNamedQuery("getAllComments", Comment.class)
                                .setParameter("report_id", r.getId())
                                .setFirstResult(15 * (page - 1))
                                .setMaxResults(15)
                                .getResultList();

            long comments_count = (long)em.createNamedQuery("getCommentsCount", Long.class)
                                    .setParameter("report_id", r.getId())
                                    .getSingleResult();

            request.setAttribute("comments", c);
            request.setAttribute("comments_count", comments_count);
            request.setAttribute("page", page);

            List<String> index = new ArrayList<String>();
            for(int i=0; i < c.size(); i++){
                String content = c.get(i).getContent();
                if(content.length() > 5) {
                    content = content.substring(0, 5) + "…";
                }
                index.add(content);
            }
            request.setAttribute("index", index);
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/reports/show.jsp");
        rd.forward(request, response);
    }

}
