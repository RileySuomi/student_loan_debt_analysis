
export default function MethodsSection() { 

    return (
        <div className="space-y-2 text-center py-10 rounded-lg shadow-md">  
            <h2 className="text-2xl font-bold">Methods</h2>
            <div>
            <h2 className="text-1xl text-left mx-6 max-w-3xl font-bold">Data Collection</h2>
                <p className="text-left mx-6 max-w-3xl text-gray-700">
                    This section we can use for the data collection methods. lol. 
                    Idk describe this section as how we collected and who collected the 
                    data we collected. And further what we did to the data to clean/wrangle.
                </p>
            <h2 className="text-1xl text-left mx-6 mt-4 max-w-3xl font-bold">Variables</h2>
                <p className="text-left mx-6 max-w-3xl text-gray-700">
                    Once we have the main dataset we perform analysis with, we can list the 
                    variables below. Use this paragraph space to describe what we did 
                    as far as naming the variables and what they mean.
                </p>
                <ul className="list-disc list-inside mx-6 mt-2 text-left">
                    <li>Year</li>
                    <li>Money</li>
                </ul>
            </div>
        </div>
    )
}