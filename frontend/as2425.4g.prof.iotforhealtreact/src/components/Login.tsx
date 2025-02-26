import React, { useState } from 'react';

interface LoginProps {
  onLoginSuccess: (username: string) => void;
}

const Login: React.FC<LoginProps> = ({ onLoginSuccess }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [role, setRole] = useState('PATIENT');
  const [okLogin, setOkLogin] = useState<boolean | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Logging in with:', role, username);

    const loginData = {
      role,
      username,
      password,
    };

    try {
        const response = await fetch('https://localhost:7242/api/Login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(loginData),
      });

      if (!response.ok) {
        throw new Error('Login failed');
      }

      const auth = await response.json();
      console.log('response', auth);

      // Save the token in localStorage
      localStorage.setItem('JWT', auth.token);

      setOkLogin(true);
      onLoginSuccess(username);
    } catch (error) {
      console.error('error', error);
      setOkLogin(false);
    }
  };

  return (
    <div className="login-container">
      <div className="login-box">
        <h2 className="login-title">Impostazioni</h2>
        <form onSubmit={handleSubmit} className="login-form">
          <select 
            value={role} 
            onChange={(e) => setRole(e.target.value)} 
            className="login-input"
          >
            <option value="PATIENT">PATIENT</option>
            <option value="DOCTOR">DOCTOR</option>
          </select>
          <input 
            type="text" 
            placeholder="Username" 
            value={username} 
            onChange={(e) => setUsername(e.target.value)} 
            className="login-input"
          />
          <input 
            type="password" 
            placeholder="Password" 
            value={password} 
            onChange={(e) => setPassword(e.target.value)} 
            className="login-input"
          />
          <button 
            type="submit" 
            className="login-button"
          >
            Login
          </button>
        </form>
        <p className="login-status">Autenticazione: {okLogin === null ? 'null' : okLogin ? 'success' : 'failed'}</p>
      </div>
    </div>
  );
};

export default Login;
