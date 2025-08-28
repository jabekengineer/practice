import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import Counter from '../concepts/Counter'

describe('Counter', () => {
  it('renders initial count of 0', () => {
    render(<Counter />)
    expect(screen.getByText('Current count: 0')).toBeInTheDocument()
  })

  it('increments count when increment button is clicked', () => {
    render(<Counter />)
    const incrementButton = screen.getByText('Increment')
    fireEvent.click(incrementButton)
    expect(screen.getByText('Current count: 1')).toBeInTheDocument()
  })

  it('decrements count when decrement button is clicked', () => {
    render(<Counter />)
    const decrementButton = screen.getByText('Decrement')
    fireEvent.click(decrementButton)
    expect(screen.getByText('Current count: -1')).toBeInTheDocument()
  })

  it('resets count to 0 when reset button is clicked', () => {
    render(<Counter />)
    const incrementButton = screen.getByText('Increment')
    const resetButton = screen.getByText('Reset')
    
    fireEvent.click(incrementButton)
    fireEvent.click(incrementButton)
    expect(screen.getByText('Current count: 2')).toBeInTheDocument()
    
    fireEvent.click(resetButton)
    expect(screen.getByText('Current count: 0')).toBeInTheDocument()
  })
})
