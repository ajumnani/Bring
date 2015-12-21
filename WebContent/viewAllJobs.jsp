<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<%@page import="com.bab.dto.JobPost"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="com.bab.dbconfig.DBConnecction"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>Bring Any Buddy (BAB)| Jobs </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Seeking Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/bootstrap-3.1.1.min.css" rel='stylesheet' type='text/css' />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Custom Theme files -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link href='//fonts.googleapis.com/css?family=Roboto:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!----font-Awesome----->
<link href="css/font-awesome.css" rel="stylesheet"> 
<!----font-Awesome----->
</head>
<body>


<%@ include file="header.jsp" %>


<div class="container">
    <div class="single">  
	   <div class="col-md-9 single_right">
	      <div class="but_list">
	       <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
			<ul id="myTab" class="nav nav-tabs" role="tablist">
			  <li role="presentation" class="active"><a href="#alljobs" id="all-jobs-tab" role="tab" data-toggle="tab" aria-controls="alljobs" aria-expanded="true">Available jobs</a></li>
			  <li role="presentation"><a href="#myapplied" role="tab" id="my-applied-tab" data-toggle="tab" aria-controls="myapplied">My Applied Jobs</a></li>
		   	  <li role="presentation"><a href="#myposted" id="my-posted-tab" role="tab" data-toggle="tab" aria-controls="myposted" aria-expanded="true">Available jobs</a></li>
			  
		   </ul>
		<div id="myTabContent" class="tab-content">
		 
		 
		 
		 
		 <%
		   
		   List<JobPost> allJobs=new ArrayList<JobPost>();
		   List<JobPost> myAppliedJobs=new ArrayList<JobPost>();
		   List<JobPost> myPostedJobs=new ArrayList<JobPost>();
		   
		   DBConnecction db=new DBConnecction();
		   Connection conn=null;
		   PreparedStatement stmt=null;
		   ResultSet rs=null;
		   try{    //: Execute a query
		        System.out.println("Creating statement...");
		   		conn=db.getJNDIConnection();
		        //All Jobs Starts here
		    	String sqlAllJobs = "select * from job_posts order by job_post_date desc";
		    	stmt = conn.prepareStatement(sqlAllJobs);
		    	System.out.println("Creating statement... 2");
		    	rs = stmt.executeQuery();
		        while (rs.next()) {
		        	JobPost jobPost=new JobPost();
		        	jobPost.setCompanyName(rs.getString("job_company"));
		        	jobPost.setExpLevel(rs.getString("job_exp_level"));
		        	jobPost.setJobDescription(rs.getString("job_description"));
		        	jobPost.setJobID(rs.getString("job_id"));
		        	jobPost.setJobPosterEmail(rs.getString("job_poster_email"));
		        	jobPost.setJobPosterName(rs.getString("job_poster_name"));
		        	jobPost.setJobTitle(rs.getString("job_tittle"));
		        	jobPost.setJobPostDate(rs.getString("job_post_date"));
					allJobs.add(jobPost);
		        }
		        
		   		
		   		if(buddy!=null){
		   		//My Applied Jobs STarts here
		        String sqlMyAppliedJobs = "select * from job_posts a,applied_jobs b where a.job_id=b.job_id and b.applier_buddy_email=> order by a.job_post_date desc";
		    	stmt = conn.prepareStatement(sqlMyAppliedJobs);
		    	stmt.setString(1, buddy.getEmailId());
				rs = stmt.executeQuery();
		        while (rs.next()) {
		        	System.out.println("Success");
		        	JobPost jobPost=new JobPost();
		        	jobPost.setCompanyName(rs.getString("job_company"));
		        	jobPost.setExpLevel(rs.getString("job_exp_level"));
		        	jobPost.setJobDescription(rs.getString("job_description"));
		        	jobPost.setJobID(rs.getString("job_id"));
		        	jobPost.setJobPosterEmail(rs.getString("job_poster_email"));
		        	jobPost.setJobPosterName(rs.getString("job_poster_name"));
		        	jobPost.setJobTitle(rs.getString("job_tittle"));
		        	jobPost.setJobPostDate(rs.getString("job_post_date"));
					myAppliedJobs.add(jobPost);
		        }
		        }
		   		
		   		
		   		if(buddy!=null){
		   		//My Posted Jobs Starts here
		        String sqlMyPostedJobs = "select * from job_posts where email=? order by job_post_date desc";
				
		    	stmt = conn.prepareStatement(sqlMyPostedJobs);
				stmt.setString(1, buddy.getEmailId());
		    	rs = stmt.executeQuery();
		        while (rs.next()) {System.out.println("Success");
	        	JobPost jobPost=new JobPost();
	        	jobPost.setCompanyName(rs.getString("job_company"));
	        	jobPost.setExpLevel(rs.getString("job_exp_level"));
	        	jobPost.setJobDescription(rs.getString("job_description"));
	        	jobPost.setJobID(rs.getString("job_id"));
	        	jobPost.setJobPosterEmail(rs.getString("job_poster_email"));
	        	jobPost.setJobPosterName(rs.getString("job_poster_name"));
	        	jobPost.setJobTitle(rs.getString("job_tittle"));
	        	jobPost.setJobPostDate(rs.getString("job_post_date"));
				myPostedJobs.add(jobPost);
		        }
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
		   
		   %> 
			
		 
		  <div role="tabpanel" class="tab-pane fade in active" id="alljobs" aria-labelledby="alljobs-tab">
		   			
			<% for(int i=0;i<allJobs.size();i++){
			JobPost jobPost=new JobPost();
			jobPost=allJobs.get(i);
			
			%>
			<div class="tab_grid">
			    <div class="jobs-item with-thumb">
				    
				    <div class="jobs_right">
						<div class="date"><%=jobPost.getJobPostDate() %></div>
						<div class="date_desc"><h6 class="title"><a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>"><%=jobPost.getJobPosterName() %></a></h6>
						  
						</div>
			
						<div class="clearfix"> </div>
                        
						<p class="description">
						Expericne require : <%=jobPost.getExpLevel() %> <br>
						Title : <%=jobPost.getJobTitle() %> <br>
						<a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>" class="read-more">Read More</a></p>
                    </div>
					<div class="clearfix"> </div>
				</div>
			 </div>
			<%} %>		 
			 
	
		
		  </div>
		  
		  <div role="tabpanel" class="tab-pane fade" id="myapplied" aria-labelledby="my-applied-tab">
		    <%if(buddy!=null){ %>	    
		    <% for(int i=0;i<allJobs.size();i++){
			JobPost jobPost=new JobPost();
			jobPost=allJobs.get(i);
			
			%>
			<div class="tab_grid">
			    <div class="jobs-item with-thumb">
				    
				    <div class="jobs_right">
						<div class="date"><%=jobPost.getJobPostDate() %></div>
						<div class="date_desc"><h6 class="title"><a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>"><%=jobPost.getJobPosterName() %></a></h6>
						  
						</div>
			
						<div class="clearfix"> </div>
                        
						<p class="description">
						Expericne require : <%=jobPost.getExpLevel() %> <br>
						Title : <%=jobPost.getJobTitle() %> <br>
						<a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>" class="read-more">Read More</a></p>
                    </div>
					<div class="clearfix"> </div>
				</div>
			 </div>
			 
			<%} %>
			 	
			  <%}else{
				 %>
				<a href="login.jsp">Please login to view this</a>				 
			 <% }%>
			
			 		 
		  </div>
		  
		  
		  
		  
		  <div role="tabpanel" class="tab-pane fade" id="myposted" aria-labelledby="my-posted-tab">
		    
		    <%if(buddy!=null){ %>
		    <% for(int i=0;i<allJobs.size();i++){
			JobPost jobPost=new JobPost();
			jobPost=allJobs.get(i);
			
			%>
			<div class="tab_grid">
			    <div class="jobs-item with-thumb">
				    
				    <div class="jobs_right">
						<div class="date"><%=jobPost.getJobPostDate() %></div>
						<div class="date_desc"><h6 class="title"><a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>&myp=y"><%=jobPost.getJobPosterName() %></a></h6>
						  
						</div>
			
						<div class="clearfix"> </div>
                        
						<p class="description">
						Expericne require : <%=jobPost.getExpLevel() %> <br>
						Title : <%=jobPost.getJobTitle() %> <br>
						<a href="viewSingleJob.jsp?jobId=<%=jobPost.getJobID() %>&jobDescription=<%=jobPost.getJobDescription() %>&myp=y" class="read-more">Read More</a></p>
                    </div>
					<div class="clearfix"> </div>
				</div>
			 </div>
			 
			
			 	
			 	 <%}
		    }
		    else{
				 %>
				<a href="login.jsp">Please login to view this</a>				 
			 
			 <%} %>
		  </div>
		
		  
		  
		  
	  </div>
     </div>
    </div>
    
   </div>
   <div class="col-md-3">
	   	  
	   	  
	   	  
	   </div>
  <div class="clearfix"> </div>
 </div>
</div>



</body>
</html>	