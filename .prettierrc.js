module.exports = {
  tabWidth: 2,
  printWidth: 100,
  overrides: [
    {
      files: "*.sol",
      options: {
        printWidth: 150,
        tabWidth: 4,
      },
    },
  ],
  plugins: [require("prettier-plugin-solidity")],
};
