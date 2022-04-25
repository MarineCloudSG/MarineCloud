module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/components/**/*.html.erb",
    "./app/components/**/*.rb",
    "./app/components/**/*.js",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.jsx",
    "./app/javascript/*.js",
    "./app/views/**/*.pdf.erb",
    "./config/initializers/heroicon.rb",
  ],
  // FIXME: Produces large bundle size
  safelist: [
    {
      pattern: /bg-/,
      variants: ["lg", "hover", "focus", "lg:hover"],
    },
  ],
  // eslint-disable-next-line global-require
  plugins: [
      require("@tailwindcss/forms"),
      require("flowbite/plugin")
  ],
  theme: {
    extend: {
      colors: {
        "light-gray": "#e3e3e3",
      },
    },
  },
};
