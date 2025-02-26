import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LoginModel } from '../models/login.model';
import { AuthModel } from '../models/auth.model';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json; charset=UTF-8',
  }),
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  // ngrok http -host-header="localhost:63539" 63539 (bind http)
  private apiUrl: string = 'https://localhost:7242/api/';

  constructor(private http: HttpClient) {}

  postAuth(login: LoginModel): Observable<AuthModel> {
    console.log(login);

    return this.http.post<AuthModel>(this.apiUrl + 'Login', login, httpOptions);
  }
}
