import { Component, EventEmitter, Output } from '@angular/core';
import { AuthModel } from '../models/auth.model';
import { LoginModel } from '../models/login.model';
import { AuthService } from '../services/auth.service';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  imports: [FormsModule, CommonModule],
  template: `
    <div class="login-container">
      <fieldset>
        <legend>Impostazioni</legend>
        <select [(ngModel)]="txtRole">
          <option value="PATIENT">PATIENT</option>
          <option value="CLINICIAN">CLINICIAN</option>
        </select>
        <input type="text" placeholder="Username" [(ngModel)]="txtUsername"/>
        <input type="password" placeholder="Password" [(ngModel)]="txtPassword"/>
        <button (click)="btnLogin_click()">Login</button>
        <div class="auth-status">
          <span>Autenticazione: </span>
          <span [ngClass]="okLogin ? 'accessGranted' : 'accessDenied'">{{okLogin}}</span>
        </div>
      </fieldset>
    </div>
  `,
  styles: [`
    .login-container {
      padding: 20px;
      background-color: #f8f9fa;
      border: 1px solid #dee2e6;
      border-radius: 6px;
      font-family: 'Arial', sans-serif;
      max-width: 400px;
      margin: 0 auto;
    }
    fieldset {
      border: none;
      padding: 0;
    }
    legend {
      font-size: 24px;
      font-weight: bold;
      text-align: center;
      margin-bottom: 20px;
    }
    select, input {
      display: block;
      width: calc(100% - 20px);
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #dee2e6;
      border-radius: 4px;
      font-size: 14px;
      margin-left: 10px;
      margin-right: 10px;
    }
    button {
      width: calc(100% - 20px);
      padding: 10px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      margin-left: 10px;
      margin-right: 10px;
    }
    button:hover {
      background-color: #0056b3;
    }
    .auth-status {
      text-align: center;
      margin-top: 10px;
      font-style: italic;
    }
    .accessGranted {
      color: green;
    }
    .accessDenied {
      color: red;
    }
  `],
  providers: [AuthService]
})
export class LoginComponent {
  @Output() loginSuccess = new EventEmitter<string>();

  txtRole: string = 'PATIENT';
  txtUsername: string = 'name.surname';
  txtPassword: string = 'password1';
  okLogin: boolean = false;
  auth: AuthModel | null = null;

  constructor(private authService: AuthService) {}

  ngOnInit() {}

  btnLogin_click(): void {
    let login = new LoginModel();
    login.role = this.txtRole;
    login.username = this.txtUsername;
    login.password = this.txtPassword;

    this.authService.postAuth(login).subscribe(
      (auth) => {
        this.auth = auth;
        console.log(this.auth);
        console.log('response', auth);

        // Save the token in localStorage
        localStorage.setItem('JWT', auth.token); // Save the JWT token

        this.okLogin = true;
        this.loginSuccess.emit(this.txtUsername);
      },
      (error) => {
        console.log('error', error);
        this.auth = error.error;
        console.log(this.auth);
        this.okLogin = false;
      }
    );
  }
}
