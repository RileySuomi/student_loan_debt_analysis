

import TitleSection from './components/TitleSection'
import AbstractSection from './components/AbstractSection'
import IntroductionSection from './components/IntroductionSection'
import MethodsSection from './components/MethodsSection'
import ResultsSection from './components/ResultsSection'
import DiscussionSection from './components/DiscussionSection'

export default function App() {

  return (
    <>
      <div className = "mx-auto max-w-3xl space-y-4 mb-20">

        <TitleSection />
        <AbstractSection />
        <IntroductionSection />
        <MethodsSection />
        <ResultsSection />
        <DiscussionSection />

      </div>
      
    </>
  )
}