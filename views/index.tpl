<html>
  <head>
    <title>Covid-19 - Report</title>
    <link
      href="https://fonts.googleapis.com/css?family=Quicksand&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <link
      rel="shortcut icon"
      href="{{ url('res', filepath='icon/favicon.ico') }}"
      type="image/x-icon"
    />
    <style>
      html {
        background-color: #000000;
        overflow: hidden;
      }
      #mainSection {
        position: absolute;
        top: 50%;
        left: 50%;
        -moz-transform: translateX(-50%) translateY(-50%);
        -webkit-transform: translateX(-50%) translateY(-50%);
        transform: translateX(-50%) translateY(-50%);
        width: 60%;
        height: 60%;
      }
      #mainHeaderFirst {
        font-family: "Roboto", sans-serif;
        color: white;
        font-size: 65px;
        text-align: center;
        letter-spacing: 10px;
        text-shadow: 5px 5px 3px rgba(0, 0, 0, 0.596);
        animation: introHeader 4s;
      }
      @keyframes introHeader {
        from {
          letter-spacing: 50px;
          opacity: 0%;
        }
        to {
          letter-spacing: 10px;
          opacity: 100%;
        }
      }
      #mainCTA {
        margin: 0;
        position: absolute;
        top: 70%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgb(0, 0, 0);
        font-family: "Quicksand", sans-serif;
        color: #ffffff;
        font-size: 20px;
        text-align: center;
        padding: 20px;
        animation: glow 800ms ease-out infinite alternate, introCTA 4s;
        -webkit-transition: background-color 1s;
        cursor: pointer;
      }
      @keyframes introCTA {
        from {
          opacity: 0%;
        }
        to {
          opacity: 100%;
        }
      }
      #mainCTA:hover {
        background-color: #e03a3c;
      }
      @keyframes glow {
        0% {
          border-color: rgb(153, 51, 51);
          box-shadow: 0 0 5px rgba(255, 0, 0, 0.2);
        }
        100% {
          border-color: rgb(255, 102, 102);
          box-shadow: 0 0 20px rgba(255, 0, 0, 0.6);
        }
      }
      #videoBG {
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
      }
      @media screen and (max-width: 600px) {
        #mainSection {
          width: 90%;
          height: 90%;
          padding: 10%;
          padding-top: 20%;
        }
        #mainHeaderFirst {
          animation: introCTA 4s;
        }
      }
    </style>
  </head>
  <body>
    <div id="exitPanel"></div>
    <div id="bg">
      <video autoplay muted loop id="videoBG">
        <source
          src="{{ url('res', filepath='video/bg01.mp4') }}"
          type="video/mp4"
        />
      </video>
    </div>
    <div id="mainSection">
      <h1 id="mainHeaderFirst">
        <strong> COV<span style="color: #e03a3c;">ID-19</span> </strong>
      </h1>
      <div id="mainCTA">View Report</div>
    </div>
  </body>
  <script>
    var mainCTA = document.getElementById("mainCTA");
    mainCTA.onclick = function () {
      self.location = "/worldmap/cases";
    };
  </script>
</html>
