import { useState, useEffect } from 'react';
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Link
} from "react-router-dom";

import Home from './pages/Home/Home';
import Vehicles from './pages/Vehicles/Vehicles';
import About from './pages/About/About';

interface MenuItem {
    title: string;
    url: string;
}

function App() {
    const [menuItems, setMenuItems] = useState<MenuItem[]>([]);

    useEffect(() => {
        fetch('/menu.json')
            .then(response => response.json())
            .then(data => setMenuItems(data.data))
            .catch(() => {
                // Fallback menu if fetch fails
                setMenuItems([
                    { title: 'Home', url: '/' },
                    { title: 'Vehicles', url: '/vehicles' },
                    { title: 'About', url: '/about' }
                ]);
            });
    }, []);

    return (
        <Router>
            <div className="router-container">
                <nav>
                    <img src="/logo.png" alt="Logistics UK Logo" className="logo" />
                    <ul>
                        {menuItems.map((item, index) => (
                            <li key={index}>
                                <Link to={item.url}>{item.title}</Link>
                            </li>
                        ))}
                    </ul>
                </nav>
                <main className="main-content">
                    <Routes>
                        <Route path="/about" element={<About />} />
                        <Route path="/vehicles" element={<Vehicles />} />
                        <Route path="/" element={<Home />} />
                    </Routes>
                </main>
            </div>
        </Router>
    )
}

export default App
