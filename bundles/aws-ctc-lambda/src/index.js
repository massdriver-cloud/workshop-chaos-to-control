const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async function (event, context) {
  // Log environment variables at startup
  console.log("Hotels Table:", process.env.HOTELS_TABLE);
  
  // Extract the HTTP method and path from the event
  const httpMethod = event.httpMethod || 'GET';
  const path = event.path || '/hotels';
  
  console.log(`Received ${httpMethod} request to ${path}`);
  console.log('Event:', JSON.stringify(event));

  try {
    // Handle different API endpoints
    if (path === '/hotels') {
      if (httpMethod === 'GET') {
        return await listHotels();
      } else if (httpMethod === 'POST') {
        return await addHotel(event);
      } else {
        return {
          statusCode: 405,
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ error: "Method not allowed" })
        };
      }
    } else {
      return {
        statusCode: 404,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ error: "Not found" })
      };
    }
  } catch (error) {
    console.error("Error processing request:", error);
    return {
      statusCode: 500,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ error: error.message })
    };
  }
};

// Function to list all hotels
async function listHotels() {
  const params = {
    TableName: process.env.HOTELS_TABLE
  };
  
  const result = await dynamoDB.scan(params).promise();
  
  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ hotels: result.Items })
  };
}

// Function to add a new hotel
async function addHotel(event) {
  // Parse the request body
  const body = event.body ? JSON.parse(event.body) : {};
  
  if (!body.name) {
    return {
      statusCode: 400,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ error: "Hotel name is required" })
    };
  }
  
  const hotel = {
    ID: Date.now().toString(), // Simple ID generation
    name: body.name,
    createdAt: new Date().toISOString()
  };
  
  const params = {
    TableName: process.env.HOTELS_TABLE,
    Item: hotel
  };
  
  await dynamoDB.put(params).promise();
  
  return {
    statusCode: 201,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ message: "Hotel added successfully", hotel })
  };
}
