import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { HeaderComponent } from './components/header.component';
import { LoginComponent } from './components/login.component';
import { ListPatientsComponent } from './components/list-patients.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, HeaderComponent, LoginComponent, ListPatientsComponent, CommonModule],
  template: `
    <app-header
      annoscolastico="AS 24/25"
      classemateria="4G INF"
      data="26/02/2025"
      autore="Prof."
      titolo="IoT for Healt"
      [username]="username"
      (logoutEvent)="logout()"
    ></app-header>
    <br/>
    <div *ngIf="!isLoggedIn">
      <app-login (loginSuccess)="onLoginSuccess($event)"></app-login>
    </div>
    <div *ngIf="isLoggedIn">
      <app-list-patients></app-list-patients>
    </div>
  `,
  styles: `
  `
})
export class AppComponent {
  title = 'as2425.prof.iotforhealt';
  isLoggedIn = false;
  username = '';

  ngOnInit() {
    const token = localStorage.getItem('JWT');
    if (token) {
      this.isLoggedIn = true;
      this.username = localStorage.getItem('username') || '';
    }
  }

  onLoginSuccess(username: string) {
    this.isLoggedIn = true;
    this.username = username;
    localStorage.setItem('username', username);
  }

  logout() {
    this.isLoggedIn = false;
    this.username = '';
    localStorage.removeItem('JWT');
    localStorage.removeItem('username');
  }
}
