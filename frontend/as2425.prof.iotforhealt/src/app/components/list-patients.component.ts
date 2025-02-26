import { Component, OnInit } from '@angular/core';
import { ApiService } from '../services/api.service';
import { Patient } from '../models/patient.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-list-patients',
  template: `
    <div class="patients-container">
      <h2>Patients List</h2>
      <ul class="patients-list">
        <li *ngFor="let patient of patients">
          <span>Username: {{ patient.username }}</span>
          <span>Name: {{ patient.name }}</span>
          <span>Surname: {{ patient.surname }}</span>
        </li>
      </ul>
    </div>
  `,
  styles: [`
    .patients-container {
      padding: 20px;
      background-color: #f8f9fa;
      border: 1px solid #dee2e6;
      border-radius: 6px;
      font-family: 'Arial', sans-serif;
    }
    .patients-container h2 {
      text-align: center;
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .patients-list {
      list-style-type: none;
      padding: 0;
    }
    .patients-list li {
      display: flex;
      justify-content: space-between;
      padding: 10px;
      border-bottom: 1px solid #dee2e6;
    }
    .patients-list li span {
      font-size: 14px;
      color: #6c757d;
    }
  `],
    imports: [CommonModule]
})
export class ListPatientsComponent implements OnInit {
  patients: Patient[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    console.log('ngOnInit');
    this.apiService.getPatients().subscribe((data: Patient[]) => {
      this.patients = data;
      console.log('patients', JSON.stringify(data));
    });
  }
}
