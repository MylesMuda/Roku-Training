'use strict'

const gulp = require('gulp')
const zip = require('gulp-zip')
const clean = require('gulp-clean')
const request = require('request')
const fs = require('fs')
const config = require('./gulp-config')

/**
 * Empty the contents of the out/ folder for a rebuild.
 */
function empty() {
    return gulp.src(`${__dirname}/${config.out_folder}`, {read: false, allowEmpty: true})
        .pipe(clean())
}

/**
 * Kill the active app for a rebuild.
 */
async function kill() {
    try {
        await sendEvent({url: `http://${config.ip}:${config.port}/keypress/home`})
    } catch(e) {
        console.error(e)
    }
}

/**
 * Package the src files as a zip, and move this to the /out directory.
 */
function pack() {
    const vinyls = [`${__dirname}/${config.src_folder}/**/*`]
    const main = `!${__dirname}/src/source/main.brs`

    if (config.runner === 'test') { 
        vinyls.push(`${__dirname}/${config.test_folder}/**/*`, main)
    }

    return gulp.src(vinyls)
        .pipe(zip(config.package_name))
        .pipe(gulp.dest(config.out_folder))
}

/**
 * Install the zip residing within the /out folder on the active Roku device,
 * running on the ip specified by config.ip.
 */
async function install() {
    try {
        const options = {
            url: `http://${config.ip}/plugin_install`,
            auth: {
                user: config.side_load_username,
                pass: config.side_load_password,
                sendImmediately: false
            },
            formData: {
                mySubmit: 'install',
                archive: fs.createReadStream(`${__dirname}/${config.out_folder}/${config.package_name}`)
            }
        }

        await sendEvent(options)
    } catch(e) {
        return console.error(e)
    }
}

/**
 * Launch the packaged application as specified by config.runner.
 */
function run() {
    let runner = undefined

    switch (config.runner) {
        case 'test': runner = test; break;
        case 'deeplink': runner = deeplink; break;
        case 'build':
        default: runner = build;
    }

    console.log("runner -> ", runner)

    return runner()
}

/**
 * Build the application for regular entry.
 */
async function build() {
    try {
        await sendEvent({uri: `http://${config.ip}:${config.port}/launch/dev`})
    } catch(e) {
        return console.error(e)
    }
}

/**
 * Build the application but also execute tests as part of this process.
 */
async function test() {
    try {
        await sendEvent({url: `http://${config.ip}:${config.port}/launch/dev?runTests=true`})
    } catch(e) {
        return console.error(e)
    }  
}

/**
 * Build the application with the intention to deeplink into content specified by config.content_id.
 */
async function deeplink() {
    try {
        await sendEvent({url: `http://${config.ip}:${config.port}/launch/dev?contentId=${config.deeplink_content_id}`})
    } catch(e) {
        return console.error(e)
    }
}

/**
 * Promisified request callback, for handling of post requests across the individually specified tasks.
 * @param {Object} Request options, see: https://www.npmjs.com/package/request for details. 
 */
function sendEvent(options) {
    return new Promise((resolve, reject) => {
        request.post(options, (error, response) => {
            const badStatusCode = response.statusCode < 200 || response.statusCode > 299
            if (error || badStatusCode) return reject(error || `Error -> ${response.statusCode}`)
            return resolve(response)
        })
    })
}

exports.default = gulp.series(gulp.parallel(empty, kill), pack, install, run)
exports.run = run
