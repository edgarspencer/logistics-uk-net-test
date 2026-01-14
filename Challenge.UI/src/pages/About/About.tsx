import './About.css';

const About = () => {
    return (
        <div className="about-page">
            <h1>About</h1>
            <div className="about-content">
                <p>
                    This is the Driver Activity Calendar application for Logistics UK.
                    It provides a comprehensive view of driver activities, shifts, and compliance status.
                </p>
                <h2>Features</h2>
                <ul>
                    <li>View driver activity for any week</li>
                    <li>Search by driver name or vehicle registration</li>
                    <li>Color-coded status indicators for activity, holidays, inefficiency, and infringements</li>
                    <li>Real-time data refresh</li>
                </ul>
            </div>
        </div>
    );
};

export default About;
