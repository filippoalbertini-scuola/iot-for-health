export const fetchWithAuth = async (url: string, options: RequestInit = {}) => {
    const token = localStorage.getItem('JWT');
    if (!token) {
      throw new Error('No token found');
    }
  
    const headers = {
      ...options.headers,
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`,
    };
  
    const response = await fetch(url, {
      ...options,
      headers,
    });
  
    if (!response.ok) {
      throw new Error('Failed to fetch');
    }
  
    return response;
  };