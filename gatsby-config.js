module.exports = {
  siteMetadata: {
    title: "Vizilog",
  },
  plugins: [
    {
      resolve: "gatsby-plugin-firebase",
      options: {
        credentials: {
          apiKey: "AIzaSyCh0pwkGXfykIzZD9Zb1K1lBmy71IPY4Ec",
          authDomain: "vizlog-9200d.firebaseapp.com",
          projectId: "vizlog-9200d",
          storageBucket: "vizlog-9200d.appspot.com",
          messagingSenderId: "270071839064",
          appId: "1:270071839064:web:00e0423ab7f2819da4cd2d",
          measurementId: "G-2JL5YGKYW6",
        },
      },
    },
    {
      resolve: "gatsby-plugin-module-resolver",
      options: {
        root: "./src", // <- will be used as a root dir
        aliases: {
          "@components": "./components", // <- will become ./src/components
        },
      },
    },
  ],
};
