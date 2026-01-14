import {
  BrowserRouter as Router,
  Routes,
  Route,
  Link
} from "react-router-dom";

import Home from './pages/Home/Home';
import Vehicles from './pages/Vehicles/Vehicles';
import About from './pages/About/About';

function App() {
    return (
        <Router>
            <div className="router-container">
                <nav>
                    <img src="./logo.png" alt="Company Logo" className="logo" />
                    <ul>
                        <li>
                            <Link to="/">Home</Link>
                        </li>
                        <li>
                            <Link to="/about">About</Link>
                        </li>
                        <li>
                            <Link to="/vehicles">Vehicles</Link>
                        </li>
                    </ul>
                </nav>
                <Routes>
                    <Route path="/about" element={<About />} />
                    <Route path="/vehicles" element={<Vehicles />} />
                    <Route path="/" element={<Home />} />
                </Routes>
            </div>
        </Router>
    )
}

export default App