import React, { useEffect, useState } from "react";
import { Patient } from "../models/Patient";

const ListPatients: React.FC = () => {
  const [patients, setPatients] = useState<Patient[]>([]);

  useEffect(() => {
    const fetchPatients = async () => {
      try {
        const token = localStorage.getItem('JWT');
        if (!token) {
          throw new Error('No token found');
        }

        const response = await fetch('https://localhost:7242/api/patients', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          }
        });

        if (!response.ok) {
          throw new Error('Failed to fetch patients');
        }

        const patients = await response.json();
        console.log('response', patients);

        setPatients(patients);
      } catch (error) {
        console.error('error', error);
      }
    };

    fetchPatients();
  }, []);

  return (
    <div className="patients-container">
      <h2>Patients List</h2>
      <ul className="patients-list">
        {patients.map((patient) => (
          <li key={patient.username}>
            <span>Username: {patient.username}</span>
            <span>Name: {patient.name}</span>
            <span>Surname: {patient.surname}</span>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ListPatients;
