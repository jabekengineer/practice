import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, it, expect } from 'vitest';
import UseActionState from '../concepts/Hooks.useActionState';

describe('RunningSumForm', () => {
    it('has default input value 1 and updates the sum on submit', async () => {
        render(<UseActionState />);

        // input should show default value of 1
        const input = screen.getByRole('spinbutton', {
            name: /amount to add/i,
        });
        expect(input).toHaveValue(1);

        // submit adding 4 -> expected sum becomes 4 (initial sum is 0)
        await userEvent.clear(input);
        await userEvent.type(input, '4');

        const button = screen.getByRole('button', { name: /add/i });
        await userEvent.click(button);

        // wait for the async increment (sleep) to complete and UI to update
        await waitFor(() => {
            expect(screen.getByText(/Current Sum/)).toHaveTextContent(': 4');
        });
    });
});
