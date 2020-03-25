<html>
  <head>
    <script src="{{ url('res', filepath='js/d3.min.js') }}"></script>
    <script src="{{ url('res', filepath='js/topojson.min.js') }}"></script>
    <script src="{{ url('res', filepath='js/datamaps.world.min.js') }}"></script>
    <link
      href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <link rel="icon" 
      type="image/png" 
    <title>Covid-19 - Report</title>
    <style>
      html {
        background-color: #000000;
        overflow: hidden;
      }
      #worldMap {
        position: fixed;
        width: 100%;
        margin: auto;
        aspect-ratio: 1.777777777777778;
        opacity: 80%;
        animation: introHeader 3s;
        z-index: 1;
        top: -50;
        transform: scale(0.95,1);
      }
      #mainHeaderFirst {
        font-family: "Roboto", sans-serif;
        color: white;
        font-size: 30px;
        animation: introHeader 5s forwards;
        letter-spacing: 1px;
        vertical-align: middle;
        transform: translate(0%, 800%);
        pointer-events: none;
      }
      .popup {
        background: white;
        font-size: small;
      }
      #headerWrapper {
        position: fixed;
        text-align: center;
        height: 99%;
        width: 100%;
        animation: headerBG 5s forwards;
        margin: auto;
        background-color: black;
        z-index: 2;
        pointer-events: none;
      }
      @keyframes headerBG {
        60% {
          opacity: 100%;
        }
        100% {
          opacity: 0%;
        }
      }

      @keyframes introHeader {
        from {
          letter-spacing: 5px;
          opacity: 0%;
        }
        40% {
          letter-spacing: 1px;
          opacity: 100%;
        }
        60% {
          letter-spacing: 1px;
          opacity: 100%;
        }
        100% {
          letter-spacing: 5px;
          opacity: 0%;
        }
      }
      @keyframes introMap {
        from {
          opacity: 0%;
        }
        to {
          opacity: 80%;
        }
      }
      #dateTime {
        font-family: "Roboto", sans-serif;
        color: white;
        font-size: 20px;
        animation: introMap 5s forwards;
      }
      #graph {
        background-color: black;
        height: 100%;
        width: 100%;
        position: fixed;
      }
    </style>
  </head>
  <body onload="setInterval(showTime, 1)">
      <div id="graph">Test</div>
      <div id="dateTime">test</div>
      <div id="headerWrapper">
      <h1 id="mainHeaderFirst">World Map (affected regions)</h1>
    </div>
    <div id="worldMap"></div>
    
  </body>
  <script>
    function showTime(){
        var today = new Date();
        var s = today.getSeconds();
        if (s < 10) {
          s = "0" + s;
        }
        var t = today.getHours() + ":" + today.getMinutes() + ":" + s;
        document.getElementById("dateTime").innerHTML = t; // display time on the page
    }
    var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g, '"'));
    var map = new Datamap({
      element: document.getElementById("worldMap"),
      responsive: true,
      done: function(datamap) {
            datamap.svg.selectAll('.datamaps-subunit').on('click', function(geography) {
                link = geography.properties.name;
                location.href = link; //change this to point at the graph page with 'link' being passed as a variable (link = country name)
      })},
      fills: {
        HIGH: "#045a8d",
        LOW: "#74a9cf",
        MEDIUM: "#2b8cbe",
        VERYLOW: "#000000",
        defaultFill: "#000000"
      },
      data: datalist,
      geographyConfig: {
        popupTemplate: function(geo, data) {
          return `<div class="popup"><strong>${
            geo.properties.name
          }</strong><hr style="color:red">Total <span style="color:blue">${
            window.location.pathname.split("/")[2]
          }</span> : ${data.numberOfThings}</div>`;
        }
      }
    });
    window.addEventListener("resize", function() {
      map.resize();
    });

  </script>
</html>
