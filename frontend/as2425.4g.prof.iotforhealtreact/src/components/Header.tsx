import React from 'react';

interface HeaderProps {
  annoscolastico: string;
  classemateria: string;
  data: string;
  autore: string;
  titolo: string;
  username?: string;
  onLogout?: () => void;
}

const Header: React.FC<HeaderProps> = ({
  annoscolastico,
  classemateria,
  data,
  autore,
  titolo,
  username,
  onLogout,
}) => {
  return (
    <header>
      <div className="header-content">
        <div className="left-section">
          <h1 className="title">{titolo}</h1>
        </div>
        <div className="middle-section">
          <p className="subtitle">
            {annoscolastico} - {classemateria} - {data}
          </p>
        </div>
        <div className="right-section">
          {username && (
            <>
              <span className="user-text">Logged in as: {username}</span>
              <button onClick={onLogout}>Logout</button>
            </>
          )}
        </div>
      </div>
      <p className="author">{autore}</p>
    </header>
  );
};

export default Header;
