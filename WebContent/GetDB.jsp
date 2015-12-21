<%@page import="com.bab.dbconfig.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Connection conn=null;
DBConnecction db=new DBConnecction();
conn=db.getJNDIConnection();
Statement stmt=null;
  
try{    //: Execute a query
    System.out.println("Creating statement...");
    stmt = conn.createStatement();

    String sql = "SELECT * from all_tables";
    ResultSet rs = stmt.executeQuery(sql);
    //STEP 5: Extract data from result set
    while(rs.next()){
       //Retrieve by column name
       String first = rs.getString(1);
       
       //Display values
      
       System.out.print(", First: " + first);
       
    }
    rs.close();
 }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
 }catch(Exception e){
    //Handle errors for Class.forName
    e.printStackTrace();
 }finally{
    //finally block used to close resources
    try{
       if(stmt!=null)
          conn.close();
    }catch(SQLException se){
    }// do nothing
    try{
       if(conn!=null)
          conn.close();
    }catch(SQLException se){
       se.printStackTrace();
    }//end finally try
 }//end try
 System.out.println("Goodbye!");


%>
</body>
</html>