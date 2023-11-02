// Simulated child vital signs data
const childData = [
    { id: 1,device_label:"Carrier One", name: "Peter", temperature: 36.7, bed: 101, age: 2, status:"okay",historicalTemperature:[
        { date: "2023-08-01", temperature: 30.7 },
        { date: "2023-08-02", temperature: 36.6 },
        { date: "2023-08-03", temperature: 30.8 },
        // Add more historical data as needed
    ] },
    { id: 2,device_label:"Carrier Two",  name: "Samuel", temperature: 36.5, bed: 102, age: 1, status:"okay",historicalTemperature:[
        { date: "2023-08-01", temperature: 36.7 },
        { date: "2023-08-02", temperature: 36.6 },
        { date: "2023-08-03", temperature: 36.8 },
        // Add more historical data as needed
    ] },
    { id: 3,device_label:"Carrier Three",  name: "Issac", temperature: 37.0, bed: 103, age: 3, status:"okay",historicalTemperature:[
        { date: "2023-08-01", temperature: 36.7 },
        { date: "2023-08-02", temperature: 36.6 },
        { date: "2023-08-03", temperature: 36.8 },
        // Add more historical data as needed
    ]},
    { id: 3,device_label:"Carrier Four",  name: "Job", temperature: 39.0, bed: 163, age: 5, status:"abnormal",historicalTemperature:[
        { date: "2023-08-01", temperature: 36.7 },
        { date: "2023-08-02", temperature: 36.6 },
        { date: "2023-08-03", temperature: 36.8 },
        // Add more historical data as needed
    ]},
    // Add more child data as needed
];

// Function to generate HTML for child vitals
function generateChildVitals(data) {
    const childList = document.getElementById("child-list");

    data.forEach(child => {
        const childCard = document.createElement("li");
        childCard.classList.add("child-card");
        childCard.innerHTML =`<h2>${child.device_label}</h2>
        <p>Temperature: ${child.temperature}°F</p>
        <div class="status-indicator ${child.status}"></div>`;
        childCard.addEventListener("click", () => displayChildInfo(child));
        childList.appendChild(childCard);
    });
}

// Function to display child information
function displayChildInfo(child) {
    const childInfoDetails = document.getElementById("child-info-details");
    childInfoDetails.innerHTML = `
        <p>Name: ${child.name}</p>
        <p>Bed Number: ${child.bed}</p>
        <p>Age: ${child.age} years</p>
    `;

  

    const historicalTemperatureDiv = document.getElementById("historical-temperature");
    historicalTemperatureDiv.innerHTML = "<h4>Temperature Data:</h4>";
    child.historicalTemperature.forEach(dataPoint => {
        historicalTemperatureDiv.innerHTML += `
            <p>Date: ${dataPoint.date}, Temperature: ${dataPoint.temperature} °C</p>
        `;
    });
}

// Initial generation of child vitals
generateChildVitals(childData);
