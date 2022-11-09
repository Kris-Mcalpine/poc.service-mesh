// express app
const express = require('express')
const app = express()
const port = 3000

const TIME_SERVICE = `http://${process.env.TIME_SERVICE}:${process.env.TIME_SERVICE_PORT}`
const USER_SERVICE = `http://${process.env.USER_SERVICE}:${process.env.USER_SERVICE_PORT}`

// routes
app.get('/', async (req, res) => {
  try {
    const timeResult = await fetch(TIME_SERVICE)
    const userResult = await fetch(`${USER_SERVICE}/1`)
    const time = await timeResult.text()
    const user = await userResult.text()
    res.send(`Hello ${user}, the time is ${time}`)
  } catch (error) {
    console.error(error)
    res.status(502)
    res.sendStatus(error)
  }
})

app.listen(port, () => {
  console.log(`Time service listening at http://localhost:${port}`)
})
