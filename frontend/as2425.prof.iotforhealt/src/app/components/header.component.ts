import { CommonModule } from '@angular/common';
import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-header',
  template: `
    <header>
      <div class="header-content">
        <div class="title-section">
          <h1>{{ titolo }}</h1>
        </div>
        <div class="subtitle-section">
          <p class="subtitle">{{ annoscolastico }} - {{ classemateria }} - {{ data }}</p>
        </div>
        <div class="user-section" *ngIf="username">
          <span>Logged in as: {{ username }}</span>
          <button (click)="logout()">Logout</button>
        </div>
      </div>
      <p class="author">{{ autore }}</p>
    </header>
  `,
  styles: [`
    header {
      background-color: #f8f9fa;
      border-bottom: 1px solid #dee2e6;
      padding: 10px;
      font-family: 'Arial', sans-serif;
    }
    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: relative;
    }
    .title-section {
      flex: 1;
      text-align: left;
    }
    .title-section h1 {
      margin: 0;
      font-size: 24px;
      font-weight: bold;
    }
    .subtitle-section {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      text-align: center;
    }
    .subtitle {
      margin: 0;
      font-size: 14px;
      color: #6c757d;
    }
    .user-section {
      display: flex;
      align-items: center;
    }
    .user-section span {
      margin-right: 10px;
      font-size: 14px;
      color: #6c757d;
    }
    button {
      padding: 5px 10px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }
    button:hover {
      background-color: #0056b3;
    }
    .author {
      text-align: center;
      font-size: 14px;
      color: #6c757d;
      margin: 0;
    }
  `],
  imports: [CommonModule]
})
export class HeaderComponent {
  @Input() annoscolastico: string = '';
  @Input() classemateria: string = '';
  @Input() data: string = '';
  @Input() autore: string = '';
  @Input() titolo: string = '';
  @Input() username: string = '';
  @Output() logoutEvent = new EventEmitter<void>();

  logout() {
    this.logoutEvent.emit();
  }
}
