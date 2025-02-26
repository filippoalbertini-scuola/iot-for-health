import React, { useState } from 'react';
import Header from './components/Header';
import Login from './components/Login';
import ListPatients from './components/ListPatients';
import './App.css';

const App: React.FC = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [username, setUsername] = useState('');

  const handleLogout = () => {
    console.log('User logged out');
    setIsLoggedIn(false);
    localStorage.removeItem('JWT');
  };

  const handleLoginSuccess = (username: string) => {
    console.log(`User ${username} logged in successfully.`);
    setIsLoggedIn(true);
    setUsername(username);
  };

  return (
    <div className="min-h-screen flex flex-col">
      <Header
        annoscolastico="AS 24/25"
        classemateria="4G INF"
        data="26/02/2025"
        autore="Prof"
        titolo="IoT for Health"
        username={isLoggedIn ? username : undefined}
        onLogout={handleLogout}
      />
      
      <div className="flex flex-grow justify-center items-center">
        {isLoggedIn ? (
          <ListPatients />
        ) : (
          <Login onLoginSuccess={handleLoginSuccess} />
        )}
      </div>
    </div>
  );
};

export default App;
