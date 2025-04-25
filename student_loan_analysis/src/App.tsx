
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'

import TitleSection from './components/TitleSection'
import AbstractSection from './components/AbstractSection'
import IntroductionSection from './components/IntroductionSection'
import MethodsSection from './components/MethodsSection'
import ResultsSection from './components/ResultsSection'
import DiscussionSection from './components/DiscussionSection'

export default function App() {

  return (
    <>
      <div className = "mx-auto max-w-3xl space-y-4">

        <TitleSection />
        <AbstractSection />
        <IntroductionSection />
        <MethodsSection />
        <ResultsSection />
        <DiscussionSection />

        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>

      </div>
      
    </>
  )
}