package www;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CommentMgr {
	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/jsp/swuapp/homepage/WebContent/www/fileupload";
	private static final String ENCTYPE = "euc-kr";
	private static int MAXSIZE = 5*1024*1024;

	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public Vector<CommentBean> getCommentList(int bnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			
			sql = "select * from  tblComment where bnum like ? ";
			pstmt = con.prepareStatement(sql);;
			pstmt.setInt(1, bnum);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setNum(rs.getInt("num"));
				bean.setBnum(rs.getInt("bnum"));
				bean.setComment(rs.getString("comment"));
				bean.setName(rs.getString("name"));
				bean.setPass(rs.getString("pass"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	public CommentBean getComment(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CommentBean bean = new CommentBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setNum(rs.getInt("bnum"));
				bean.setName(rs.getString("comment"));
				bean.setName(rs.getString("name"));
				bean.setName(rs.getString("pass"));				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// ´ñ±Û ÀÔ·Â
		public void insertComment(HttpServletRequest req) throws IOException {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MultipartRequest multi = null;
			
			multi = new MultipartRequest(req, SAVEFOLDER);
			
			try {
				con = pool.getConnection();
				
				sql = "insert tblComment(bnum, comment, name, pass)";
				sql += "values(?, ?, ?, ?)";
		
				
				
				pstmt = con.prepareStatement(sql);
				
				
				
				pstmt.setInt(1, Integer.parseInt(multi.getParameter("bnum")));
				pstmt.setString(2, multi.getParameter("comment"));
				pstmt.setString(3, multi.getParameter("cname"));
				pstmt.setString(4, multi.getParameter("pass"));
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
	
	
	
	public void updateComment(CommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard set name=?,comment=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getComment());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public int getTotalCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			
			sql = "select count(num) from tblComment";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();

			sql = "delete from tblComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
}
