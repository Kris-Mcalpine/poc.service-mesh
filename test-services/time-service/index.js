// express app
const express = require('express')
const app = express()
const port = 3000

//routes
app.get('/', (req, res) => {
  res.send(new Date().toISOString())
})

app.listen(port, () => {
  console.log(`Time service listening at http://localhost:${port}`)
})
