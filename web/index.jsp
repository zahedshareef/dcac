<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.DB_Conn"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC</title>
    <jsp:useBean class="product.product" id="product" scope="session"></jsp:useBean>
    <%@page import="java.sql.*, database.*" %>
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script>
    <style type="text/css">
      .main-header {position: relative;margin: 0 auto;margin-top: -20px;padding: 3em 1em;color: #fff;text-align: center;background: url(assets/img/bgheader.jpg) no-repeat center center;background-size: cover;}
     .main-header h1 {font-size: 2.625em;line-height: 1.3;margin: 0;font-weight: 300;}
     .main-header h1 span {display: block;font-size: 60%;opacity: 0.7;padding: 0 0 0.6em 0.1em;}
     #ebook {-moz-box-shadow:inset 0 0 10px #8fb260;-webkit-box-shadow:inset 0 0 10px #8fb260;box-shadow:inset 0 0 25px -10px #8fb260;}
     #responsive {-moz-box-shadow:inset 0 0 10px #000000;-webkit-box-shadow: inset 0 0 10px #000000;box-shadow:inset 0 0 25px -10px #ffa7a2;}
    </style>
</head>
<body>
 
   <a href="#content" class="sr-only">Skip to main content</a>
   <%
   if (session.getAttribute("user") == null ){// THen new user, show join now
       %>
       <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
   <%
   }else {
       %>
       <jsp:include page="includesPage/_logout.jsp"></jsp:include>
   <%
   }
   %>
  <section id="main">
   <header id="bgimg" class="main-header">
      <h1>Book Catalog <span>Now featuring a large collection to choose from</span></h1>	
   </header>
   <div class="container" style="margin-top: 1em;">
    <div class="row">
        <div class="col-md-3 visible-xs visible-sm">
            <div class="sidebar affix-top" role="complementary">
                <ul class="nav sidenav">
                    <li class="list-group active"><a href="#"><em><strong>Categories</strong></em></a></li>
                    <li><a href="viewProducts_.jsp">View Products</a></li>      
                </ul>
            </div>
        </div>
      <!--col-md-9-->   
        <div class="col-md-9">
          <div class="row" style="margin-bottom: 20px;">
            <div class="col-sm-12 img-responsive">
                <a href="viewProducts_.jsp">
                <img src="assets/img/banner/engineering.png" class="img-rounded img-responsive" alt="Books Available" />
                </a>
            </div>
          </div>
          <jsp:include page="includesPage/mainHeaders/index_latestAddedProducts.jsp"></jsp:include>
          <div class="hidden-sm hidden-xs">
             <jsp:include page="includesPage/mainHeaders/topMostViewedProducts_4.jsp"></jsp:include>
          </div>

        </div><!--/.col-md-9-->
        <div class="col-md-3">               
        <%
            String category, subcategory;
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT * FROM  `products` p "
                            + "INNER JOIN  `images` i "
                            + "USING (  `product-name` ) ");
            category = "";
            subcategory = "";
            if(session.getAttribute("cat") != null ){
                category = (String) session.getAttribute("cat");
                ArrayList subCat = product.getSubcategory(category);
                %>

                 <%
                if (session.getAttribute("scat") != null){
                    subcategory = (String) session.getAttribute("scat");
                }
            } else {
                //Show Category
                ArrayList Cat = product.getCategory();
                %>
                <div class="sidebar affix-top hidden-xs hidden-sm" role="complementary">
                    <ul class="nav sidenav">
                        <li class="list-group hidden-sm hidden-xs active"><a href="#"><em><strong>Categories</strong></em></a></li>
                <%
                for (int i =0; i< Cat.size(); i++){
                    %>
                    <li><a href="addProductFilters.jsp?cat=<%= Cat.get(i) %>"><%= Cat.get(i) %></a></li>      
                    <%
                } Cat.clear();
                %>
                    </ul>
                </div>
                <%
            }
            %>
            <div class="alert hidden-xs hidden-sm" id="ebook" style="background-color: #ecf2e4;">
                <h4 style="border-bottom:1px solid #dadada;">eBooks<br />
                    <small style="color: #40826d;">Discover a new way reading</small></h4>
                <span></span>
                <p style="padding: 5px;">What is an eBook?<br />
                    An electronic avatar of the book</p>
                <img id="ebookimg" class="hidden-md" src="assets/img/ebook_illustration.png" alt="ebook"/>
                <img class="visible-md" src="assets/img/ebook_illustration.png" width="180" alt="responsive"/>
                <div style="text-align: center;">
                    <a class="btn btn-outline" style="color: #000;text-decoration: none;" href="www.google.com">Know More <i class="fa fa-caret-right fa-fw"></i></a>
                </div>
            </div>
            <div class="alert alert-dismissable hidden-xs hidden-sm" id="responsive" style="background-color: #f7f1f0;">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <dl style="text-align: justify;">
                    <dt>Responsive Layout</dt>
                    <img class="hidden-sm hidden-md" style="padding: 10px;" src="assets/img/responsivelog.png" width="240" alt="responsive"/>
                    <img class="visible-md" src="assets/img/responsive.png" width="180" alt="responsive"/>
                    <dd>Our website is fully responsive with mobile support. Try resizing the browser on your desktop to see it in action!</dd>
                </dl>
            </div>
       </div>
      </div>
    </div><!-- /.container -->
</section><!--/.main-->
<jsp:include page="includesPage/_footer.jsp"></jsp:include>
</body>
</html>
