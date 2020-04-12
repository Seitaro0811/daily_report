package models;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Table(name = "comments")
@NamedQueries({
    @NamedQuery(
            name = "getAllComments",
            query = "SELECT c FROM Comment AS c WHERE c.report_id = :report_id ORDER BY c.id DESC"
            ),
    @NamedQuery(
            name = "getCommentsCount",
            query = "SELECT COUNT(c) FROM Comment AS c WHERE c.report_id = :report_id"
            )
})

@Entity
public class Comment {
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getReport_id() {
        return report_id;
    }

    public void setReport_id(Integer report_id) {
        this.report_id = report_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "report_id", nullable = false)
    private Integer report_id;

    @Column(name = "name", nullable = false)
    private String name;

    @Lob
    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "create_at", nullable = false)
    private Timestamp create_at;
}
