<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<style>
table, td {
    border: 1px solid black;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">  
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/metisMenu/2.7.0/metisMenu.js"></script> -->
<script src="https://github.com/kayalshri/tableExport.jquery.plugin/blob/master/html2canvas.js"></script>
<script src="https://raw.githubusercontent.com/kayalshri/tableExport.jquery.plugin/master/jspdf/jspdf.js"></script>
<script src="https://raw.githubusercontent.com/kayalshri/tableExport.jquery.plugin/master/jspdf/libs/base64.js"></script>
<script src="https://raw.githubusercontent.com/kayalshri/tableExport.jquery.plugin/master/jspdf/libs/sprintf.js"></script>

<script language="javascript" type="text/javascript" src="viz.js"></script>
<script language="javascript" type="text/javascript" src="site.js"> </script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<title>Script Analyzer - Consolidated Table List</title>
   
	<script> 
var arrResponse;
window.onload = function() {
	arrResponse=${data};
	var i;	
	
	
    
    var out = "<div>ACTIONS: C = CREATE ; CV = CREATE VOLATILE ; I = INSERT ; MI = MERGE INSERT ; U = UPDATE ; MU = MERGE UPDATE ; D = DELETE</div><table id='test' border=3><caption style=color:white;background-color:Tomato;>CONSOLIDATED TABLE</caption><tr bgcolor=#87cefa;><td>Code Block</td><td>Action</td><td>Source Table</td><td>Target Table</td><td>Standalone Table</td></tr>";

    for(i = 0; i < arrResponse.codeBlocks.length; i++) {
    	//new code 10/10/17 starts
    	var temp1 = String(arrResponse.codeBlocks[i].dbSrcTables);
        var temp2 = String(arrResponse.codeBlocks[i].dbTargetTables);
        var temp3 = String(arrResponse.codeBlocks[i].dbStAloneTables);
        
        // Correction For SourceTable
        for( x=0; x < 5; x++ ){
	    	if( temp1.indexOf("$") !== -1 ){
	    	    temp1 = temp1.replace(/{(.*?)}/,"" );
	    	    temp1 = temp1.replace("$.","" );
	    	}
	    	temp1 = temp1.replace( /,,/ , "," );
	    	if( temp1.indexOf("(SELECT,") >= 0 || temp1.indexOf("(,") >= 0 ){
		    	temp1 = temp1.replace( "(SELECT," , "" );
		    	temp1 = temp1.replace( "(," , "" );
		    }
	    	if( temp1.indexOf("$") >= 0 && temp1.indexOf("_DB.") >= 0 && temp1.indexOf("$") < temp1.indexOf("_DB.") ){
	    		temp1 = temp1.replace(temp1.substring( temp1.indexOf("$") , temp1.indexOf("_DB.")+4 ) , "");
	    	}
	    	if( temp1.indexOf("/*") >= 0 && temp1.indexOf("*/") >= 0 && temp1.indexOf("/*") < temp1.indexOf("*/") ){
		    	temp1 = temp1.replace( /\/(.*?)\// , "" );
		    }
	    }
	    temp1 = temp1.replace( "(" , "" );
	    
	 // Correction For TargetTable
        for( x=0; x < 5; x++ ){
	    	if( temp2.indexOf("$") !== -1 ){
	    	    temp2 = temp2.replace(/{(.*?)}/,"" );
	    	    temp2 = temp2.replace("$.","" );
	    	}
	    	temp2 = temp2.replace( /,,/ , "," );
	    	if( temp2.indexOf("(SELECT,") >= 0 || temp2.indexOf("(,") >= 0 ){
		    	temp2 = temp2.replace( "(SELECT," , "" );
		    	temp2 = temp2.replace( "(," , "" );
		    }
	    	if( temp2.indexOf("$") >= 0 && temp2.indexOf("_DB.") >= 0 && temp2.indexOf("$") < temp2.indexOf("_DB.") ){
	    		temp2 = temp2.replace(temp2.substring( temp2.indexOf("$") , temp2.indexOf("_DB.")+4 ) , "");
	    	}
	    	if( temp2.indexOf("/*") >= 0 && temp2.indexOf("*/") >= 0 && temp2.indexOf("/*") < temp2.indexOf("*/") ){
		    	temp2 = temp2.replace( /\/(.*?)\// , "" );
		    }
	    }
	    temp2 = temp2.replace( "(" , "" );
	    
	 // Correction For StandAloneTable
        for( x=0; x < 5; x++ ){
	    	if( temp3.indexOf("$") !== -1 ){
	    	    temp3 = temp3.replace(/{(.*?)}/,"" );
	    	    temp3 = temp3.replace("$.","" );
	    	}
	    	temp3 = temp3.replace( /,,/ , "," );
	    	if( temp3.indexOf("(SELECT,") >= 0 || temp3.indexOf("(,") >= 0 ){
		    	temp3 = temp3.replace( "(SELECT," , "" );
		    	temp3 = temp3.replace( "(," , "" );
		    }
	    	if( temp3.indexOf("$") >= 0 && temp3.indexOf("_DB.") >= 0 && temp3.indexOf("$") < temp3.indexOf("_DB.") ){
	    		temp3 = temp3.replace(temp3.substring( temp3.indexOf("$") , temp3.indexOf("_DB.")+4 ) , "");
	    	}
	    	if( temp3.indexOf("/*") >= 0 && temp3.indexOf("*/") >= 0 && temp3.indexOf("/*") < temp3.indexOf("*/") ){
		    	temp3 = temp3.replace( /\/(.*?)\// , "" );
		    }
	    }
	    temp3 = temp3.replace( "(" , "" );
        if (temp1.trim().startsWith(",")){temp1 = temp1.trim().replace(",","");}
        if (temp1.trim().includes(",,")){temp1 = temp1.trim().replace(",,",",");}
        if (temp1.trim().endsWith(";")){temp1 = temp1.trim().replace(";","");}
        if (temp1.trim().endsWith(",")){temp1 = temp1.trim().replace(",","");}
        if (temp2.trim().startsWith(",")){temp2 = temp2.trim().replace(",","");}
        if (temp2.trim().includes(",,")){temp2 = temp2.trim().replace(",,",",");}
        if (temp2.trim().endsWith(";")){temp2 = temp2.trim().replace(";","");}
        if (temp2.trim().endsWith(",")){temp2 = temp2.trim().replace(",","");}
        if (temp3.trim().startsWith(",")){temp3 = temp3.trim().replace(",","");}
        if (temp3.trim().includes(",,")){temp3 = temp3.trim().replace(",,",",");}
        if (temp3.trim().endsWith(";")){temp3 = temp3.trim().replace(";","");}
        if (temp3.trim().endsWith(",")){temp3 = temp3.trim().replace(",","");}
        if (temp1.trim() != "" || temp2.trim() != "" || temp3.trim() != ""){
                out += "<tr><td><center>" + 
                arrResponse.codeBlocks[i].cbid +
                "</center></td><td><center>" +
                arrResponse.codeBlocks[i].action +
                "</center></td><td><center>" +
                temp1 +
                "</center></td><td><center>" +
                temp2 +
                "</center></td><td><center>" +
                temp3 +
                "</center></td></tr>";}
	    //new code ends
	    //old code commented below
        //out += "<tr><td><center>" + 
        //arrResponse.codeBlocks[i].cbid +
        //"</center></td><td><center>" +
        //arrResponse.codeBlocks[i].action +
        //"</center></td><td><center>" +
        //arrResponse.codeBlocks[i].dbSrcTables +
        //"</center></td><td><center>" +
        //arrResponse.codeBlocks[i].dbTargetTables +
        //"</center></td><td><center>" +
        //arrResponse.codeBlocks[i].dbStAloneTables +
        //"</center></td></tr>";
    }
    out += "</table>";
    document.getElementById("tabledata").innerHTML = out;
   
    
   
   
	
	/*   document.writeln("<table border=3 >");
	  document.writeln("<caption style=color:white;background-color:Tomato;>CONSOLIDATED TABLE</caption>");
	    document.writeln("<tr bgcolor=#87cefa;><th>Code Block</th>");
		 document.writeln("<th>Action</th>");
	   document.writeln("<th>Source Table</th>");
		 document.writeln("<th>Target Table</th>");
		document.writeln("<th>Standalone Table</th></tr>");
		document.writeln("<form  method=get id=analyzedifffile> <input type=button value=HOME onclick='showData()'></form>");
        
		//document.write("<a href=../scriptanalyzerweb/fileprocess>Go Back</a>");
		//document.writeln("<th><a href="analysisdetails.jsp">Back</a></th></tr>");
	         
	for(var i=0;i<arrResponse.codeBlocks.length;i++){   
	   document.writeln("<tr><td width = 50><center>" + arrResponse.codeBlocks[i].cbid+"</center></td>");
	   document.writeln("<td width = 50><center>" + arrResponse.codeBlocks[i].action +"</center></td>");
	   document.writeln("<td width = 50><center>" + arrResponse.codeBlocks[i].dbSrcTables +"</center></td>");
	   document.writeln("<td width = 50><center>" + arrResponse.codeBlocks[i].dbTargetTables +"</center></td>");
	   document.writeln("<td width = 50><center>" + arrResponse.codeBlocks[i].dbStAloneTables +"</center></td></tr>");
	} 
	
	              document.writeln("</table>"); */
	              
	             //document.writeln("<a href=""../analysisdetails.jsp"">BACK</a>");
	            
	 };
        
	  function showData()
	     {
	    	
    POST('list', {"a":"aa"}); 
    
	     }
	  function alertF()
	     {
	    	alert("hello");
	    	alert(tabledata);
 
	     }
	  function POST(path, params, method) {
	      method = method || "post"; // Set method to post by default if not specified.

	      // The rest of this code assumes you are not using a library.
	      // It can be made less wordy if you use one.
	      var form = document.createElement("form");
	      form.setAttribute("method", method);
	      form.setAttribute("action", path);

	      for(var key in params) {
	          if(params.hasOwnProperty(key)) {
	              var hiddenField = document.createElement("input");
	              hiddenField.setAttribute("type", "hidden");
	              hiddenField.setAttribute("name", key);
	              hiddenField.setAttribute("value", params[key]);
	  			//alert( key);

	  //alert( params[key]);
	              form.appendChild(hiddenField);
	           }
	      }

	      document.body.appendChild(form);
	      form.submit();
	  } 
	//testbutton.setAttribute('onclick',"$('#test').tableExport({type:'pdf',escape:'false'});");
      </script>		
      </head>

<body>	
<form  method=get id=analyzedifffile> <input type=button value=HOME onclick='showData()'></form>
<div id="testdiv"> 
<button class="btn btn-primary btn-outline btn-block" onclick="$('#test').tableExport({type:'pdf',escape:'false'});">Export Table</button>  </div>

<div id="tabledata">
</div>

	
</body>


</html>