#!/usr/bin/env node
const path = require("path");
const fs = require("fs");
const chalk = require("chalk");
const yargs = require("yargs");

yargs
  .alias("v", "version")
  .usage("Usage: $0 [options]")
  .help("h")
  .alias("h", "help")
  .strict(true).argv;

// Set up logging methods
const log = {
  info: msg =>
    console.log(`${chalk.bgGreen.black(" INFO ")} ${chalk.green(msg)}`),
  warn: msg =>
    console.log(`${chalk.bgYellow.black(" WARN ")} ${chalk.yellow(msg)}`),
  skip: msg => console.log(`${chalk.bgGray(" SKIP ")} ${msg}`),
  error: msg =>
    console.log(`${chalk.bgRed.black(" ERROR ")} ${chalk.red(msg)}`),
};

// const packageName = "@eliasnorrby/dependabot-config";

if (!fs.existsSync("package.json")) {
  log.error(
    "No package.json found in the current directory. Make sure you are in the project root. If no package.json exists yet, run `npm init` first.",
  );
  process.exit(1);
}

const configDir = ".dependabot";

if (!fs.existsSync(configDir)) {
  log.info(`Creating ${configDir} directory`);
  fs.mkdirSync(configDir);
}

const config = fs.readFileSync(path.resolve(__dirname, "config.yml"), "utf8");

process.chdir(configDir);

// Config files to write
const CONFIG_FILES = {
  "config.yml": config,
};

const failedToWrite = {};

Object.entries(CONFIG_FILES).forEach(([fileName, contents]) => {
  if (!fs.existsSync(fileName)) {
    log.info(`Writing ${fileName}`);
    fs.writeFileSync(fileName, contents, "utf8");
  } else {
    log.skip(`${fileName} already exists`);
    failedToWrite[fileName] = true;
  }
});

log.info("Done!");
