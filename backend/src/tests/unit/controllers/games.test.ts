import * as gameService from '../../../services/gameService';
import fakeGame from '../../data/game.json'
describe("getGame controller", () => {
    const mockReq = (id: string) => ({
        params: {id},
    });

    const mockRes = () => {
        const res: any = {};
        res.json = jest.fn();
        return res;
    }

    const mockNext = jest.fn();

    test('should return game data when endpoint called', () => { 
        jest.spyOn(gameService, "getGame").mockResolvedValue({...fakeGame, date: new Date(fakeGame.date), movie : {...fakeGame.movie,
            releaseDate : new Date(fakeGame.movie.releaseDate),
            updatedAt : new Date(fakeGame.movie.updatedAt),
            createdAt : new Date(fakeGame.movie.createdAt)
        }});
     })
})