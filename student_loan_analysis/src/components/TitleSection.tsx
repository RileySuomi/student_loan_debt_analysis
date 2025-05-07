// TitleSection.tsx

export default function TitleSection() {
    return (
        <div className="space-y-2 text-center py-10 rounded-lg shadow-md">
            <h1 
            className="text-5xl font-bold tracking-light mb-2">
                Degrees of Debt: The Rise of Student Loans Over Time
            </h1>
            <div className="flex items-center mt-4 space-x-4 text-gray-400 justify-center">
                <span> Riley Suomi, Dalton Mermis, Pablo Preciado, Belle Burnside</span>
            </div>
            <div className="flex items-center space-x-4 text-gray-400 justify-center">
                <span> Seattle Pacific University</span>
                <div className="h-4 w-px bg-gray-400"></div>
                <span> DAT4500</span>
            </div>
        </div>
    );
}
