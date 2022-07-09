/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./pages/**/*.{js,ts,jsx,tsx}", "./components/**/*.{js,ts,jsx,tsx}"],
  theme: {
    fontFamily: {
      sans: [
        "Inter",
        "SF Pro Text",
        "-apple-system",
        "BlinkMacSystemFont",
        '"Segoe UI"',
        "Roboto",
        '"Helvetica Neue"',
        "Arial",
        '"Noto Sans"',
        "sans-serif",
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
        '"Noto Color Emoji"',
      ],
      mono: ["Source Code Pro", "monospace"],
    },
    extend: {
      colors: {
        label: "rgba(255,255,255, 0.90)",
        background: "#0d1117",
        border: "#21262d",
        surface: "rgba(255,255,255,0.10)",
        primary: "#58a6ff",
      },
    },
  },
  plugins: [],
};
