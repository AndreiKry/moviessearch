import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.logging.Logger;


@WebServlet("/DarthSidious")
public class DarthSidious extends HttpServlet {
    HttpURLConnection urlConnection;
    BufferedReader reader;
    private static Logger log = Logger.getLogger(DarthSidious.class.getName());
    String charset="UTF-8";


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String title = req.getParameter("title");
        String year = req.getParameter("year");
        String plot = req.getParameter("plot");
        log.info(title+"   "+year+"  "+plot);
        String  URL = "http://www.omdbapi.com/";
        String requestUrl = URL+"?t="+ URLEncoder.encode(title, charset)+"&y="+year+"&plot="+plot+"&r=json";
        log.info(requestUrl);



        java.net.URL url = new URL(requestUrl);
        urlConnection = (HttpURLConnection) url.openConnection();
        urlConnection.setRequestMethod("GET");
        urlConnection.setDoInput(true);
        urlConnection.setDoOutput(true);
        urlConnection.setRequestProperty("Accept-Language", charset);
        urlConnection.connect();

        InputStream inputStream = urlConnection.getInputStream();
        StringBuilder buffer = new StringBuilder();

        reader = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }

        String resultJson = buffer.toString();
        log.info("LOG result " + resultJson);


        JSONObject obj = new JSONObject(resultJson);

        String rspTitle = obj.getString("Title");
        String rspYear = obj.getString("Year");
        String rspRated = obj.getString("Rated");
        String rspReleased = obj.getString("Released");
        String rspRuntime = obj.getString("Runtime");
        String rspGenre = obj.getString("Genre");
        String rspDirector = obj.getString("Director");
        String rspWriter = obj.getString("Writer");
        String rspActors = obj.getString("Actors");
        String rspPlot = obj.getString("Plot");
        String rspLanguage = obj.getString("Language");
        String rspCountry = obj.getString("Country");
        String rspAwards = obj.getString("Awards");
        String rspPoster = obj.getString("Poster");
        String rspimdbRating = obj.getString("imdbRating");
        String rspimdbVotes = obj.getString("imdbVotes");
        String rspType = obj.getString("Type");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JSONArray ar = new JSONArray();
        JSONObject respJson = new JSONObject();
        respJson.put("rspTitle", rspTitle);
        respJson.put("rspYear", rspYear);
        respJson.put("rspRated", rspRated);
        respJson.put("rspReleased", rspReleased);
        respJson.put("rspRuntime", rspRuntime);
        respJson.put("rspGenre", rspGenre);
        respJson.put("rspDirector", rspDirector);
        respJson.put("rspWriter", rspWriter);
        respJson.put("rspActors", rspActors);
        respJson.put("rspPlot", rspPlot);
        respJson.put("rspLanguage", rspLanguage);
        respJson.put("rspCountry", rspCountry);
        respJson.put("rspAwards", rspAwards);
        respJson.put("rspPoster", rspPoster);
        respJson.put("rspimdbRating", rspimdbRating);
        respJson.put("rspimdbVotes", rspimdbVotes);
        respJson.put("rspType", rspType);
        ar.put(respJson);

        log.info("LOG restJson " + ar);
        //log.info("THIS " + resultJson.toString());

        resp.getWriter().write(ar.toString());


    }
}
