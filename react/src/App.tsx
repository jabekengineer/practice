import { useState } from 'react'

import UseActionState from '../concepts/Hooks.useActionState'
import { ConceptRunner } from './runner'

function App() {
  const [selectedConcept, setSelectedConcept] =
    useState<string>('UseActionState')

  const concepts = {
    UseActionState: UseActionState,
  }

  return (
    <div style={{ padding: '20px' }}>
      <h1>React Practice</h1>

      <div style={{ marginBottom: '20px' }}>
        <label htmlFor="concept-select">Select Concept: </label>
        <select
          id="concept-select"
          value={selectedConcept}
          onChange={e => setSelectedConcept(e.target.value)}
          style={{ padding: '5px', marginLeft: '10px' }}
        >
          {Object.keys(concepts).map(concept => (
            <option key={concept} value={concept}>
              {concept.charAt(0).toUpperCase() + concept.slice(1)}
            </option>
          ))}
        </select>
      </div>

      <div
        style={{
          border: '1px solid #ccc',
          padding: '20px',
          borderRadius: '5px',
        }}
      >
        <ConceptRunner concepts={concepts} selectedConcept={selectedConcept} />
      </div>
    </div>
  )
}

export default App
