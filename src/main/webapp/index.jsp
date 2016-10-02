<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>MOVIES SEARCH</title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
  </head>
  <body class="bg-orange">

  <div class="col-md-12 text-center">
    <h1>What We Look For?</h1>
  </div>

    <div class="col-md-12 text-center">
      <div class="col-md-4 col-sm-12 col-xs-12">
        <label class="control-label" for="t">Title:</label>
        <input type="text" id="t" name="t" class="inp-text" size="30">
        &nbsp;&nbsp;
      </div>
      <div class="col-md-4 col-sm-12 col-xs-12">
        <label class="control-label" for="y">Year:</label>
        <input type="text" id="y" name="y" class="inp-text" maxlength="4" size="6" style="width: 100px;">
        &nbsp;&nbsp;
        <label class="control-label">Plot:</label>
        <select name="plot" id="p" style="width: 100px;">
          <option value="short" selected="">Short</option>
          <option value="full">Full</option>
        </select>
        &nbsp;&nbsp;
      </div>
      <div class="col-md-4 col-sm-12 col-xs-12">
        <button id="buttonsnd" type="button" class="btn-orange">Search</button>
        <button id="reset" type="reset" class="btn-orange">Reset</button>
      </div>

    </div>

   <div id="inv" class="invv">
    <div class="col-md-12 text-center">
      <h1>What We Were Looking For?</h1>
    </div>

    <div class="col-md-12"><!-- MAIN -->
      <div class="col-md-4 col-sm-6 col-xs-12 text-center"><!-- POSTER + IMDB -->
        <img id="poster" src=""><!-- POSTER -->

        <div><!-- IMDB -->
          <strong>
          <span class="sp-text marge" id="IMDB"></span>
          </strong>
        </div>
      </div>

      <div class="col-md-8 col-sm-6 col-xs-12"><!-- TITLE + MINI + PLOT + DIRECTORS + WRITTERS + STARS -->
        <div class="text-center"><!-- TITLE -->
          <h3 id="title_year"></h3>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12 text-center"><!-- MINI -->
          <div class="col-md-2 col-sm-3 col-xs-4"><!-- RATEING -->
            <span class="sp-tt" id="rateing"></span>
          </div>
          <div class="col-md-2 col-sm-3 col-xs-4"><!-- RUNTIME -->
            <span class="sp-tt" id="runtime"></span>
          </div>
          <div class="col-md-2 col-sm-2 col-xs-4"><!-- RELEAZED -->
            <span class="sp-tt" id="releazed"></span>
          </div>
          <div class="col-md-6 col-sm-4 col-xs-12"><!-- GENRE -->
            <span class="sp-tt" id="genre"></span>
          </div>

        </div>
        <div ><!-- PLOT -->
          <span class="sp-text marge" id="plot"></span>
        </div>
        <div><!-- DIRECTORS -->
          <span class="sp-text marge" id="direct"></span>
        </div>
        <div><!-- WRITTERS -->
          <span class="sp-text marge" id="writers"></span>
        </div>
        <div><!-- STARS -->
          <span class="sp-text marge" id="stars"></span>
        </div>
      </div>

    </div>
    <div class="col-md-12 text-center bg-gold"><!-- AWARDS -->
      <h3 id="awards"></h3>
    </div>
   </div>
    <script src="http://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(document).ready(function () {
        $("#buttonsnd").click(btnsnd);
        $("#reset").click(reset);
      });

      function reset() {
        $("#inv").css("display","none");
        $('#t').val("");
        $("#y").val("");
      }

      function btnsnd(){
        var title = $('#t').val();
        var year = $("#y").val();
        var plot = $("#p").val();
        $("#inv").css("display","block");
        $.post('DarthSidious', {
          "title" : title, "year" : year, "plot" : plot
        }, function(responseText) {
          print(responseText);
        }).fail(function() {
          alert("Response error");
        });
      };

      function print (json) {
        $.each(json, function(i, ptintObject) {
          var rspTitle = ptintObject.rspTitle;
          var rspYear = ptintObject.rspYear;
          var rspRated = ptintObject.rspRated;
          var rspReleased = ptintObject.rspReleased;
          var rspRuntime = ptintObject.rspRuntime;
          var rspGenre = ptintObject.rspGenre;
          var rspDirector = ptintObject.rspDirector;
          var rspWriter = ptintObject.rspWriter;
          var rspActors = ptintObject.rspActors;
          var rspPlot = ptintObject.rspPlot;
          //var rspLanguage = ptintObject.rspLanguage;
          //var rspCountry = ptintObject.rspCountry;
          var rspAwards = ptintObject.rspAwards;
          var rspPoster = ptintObject.rspPoster;
          var rspimdbRating = ptintObject.rspimdbRating;
          var rspimdbVotes = ptintObject.rspimdbVotes;
          //var rspType = ptintObject.rspType;

          $("#poster").attr({
            src: rspPoster });
          $("#title").text(rspTitle);
          $("#title_year").text(rspTitle+" ("+rspYear+")");
          $("#runtime").text(rspRuntime);
          $("#genre").text(rspGenre);
          $("#releazed").text(rspReleased);
          $("#rateing").text(rspRated);
          $("#plot").text("PLOT: " + rspPlot);
          $("#direct").text("DIRECTORS: " + rspDirector);
          $("#writers").text("WRITERS: " + rspWriter);
          $("#stars").text("STARS: " + rspActors);
          $("#awards").text(rspAwards);
          $("#IMDB").text("IMDB: " + rspimdbRating + " Votes: " + rspimdbVotes);
        });
      };
    </script>
  </body>
</html>
