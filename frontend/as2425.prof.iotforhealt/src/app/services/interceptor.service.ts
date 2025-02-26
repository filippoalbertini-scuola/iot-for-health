import { HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class InterceptorService implements HttpInterceptor{
  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<any> {
    const token = localStorage.getItem('JWT'); // Retrieve JWT token from localStorage
    if (token) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`, // Attach the token to the Authorization header
        },
      });
    }
    return next.handle(request);
  }
}
