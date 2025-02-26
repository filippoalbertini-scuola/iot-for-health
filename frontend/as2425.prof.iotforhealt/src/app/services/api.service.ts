import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Patient } from '../models/patient.model';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  apiUrl: string = 'https://localhost:7242/api/';

  constructor(private httpClient: HttpClient) {}

  public getPatients(): Observable<Patient[]> {
    return this.httpClient.get<Patient[]>(this.apiUrl + 'patients');
  }
}
